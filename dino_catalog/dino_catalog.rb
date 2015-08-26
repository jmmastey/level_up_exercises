require 'json'
require_relative 'dinodex'
require_relative 'criterium'
require_relative 'errors'
require_relative 'import_loop'

class DinodexApp
  ALLOWED_COMMANDS = %w(help ? exit done quit)

  TEXT_INTRO = <<-eos
***********
* Dinodex *
***********

Welcome to the Dinodex!
The following data files are available, which would you like to use?

eos

  TEXT_HELP = <<-eos

***** HELP *****

Format: [is |are [not ]]<field> [not |! ]<operator> <value>[ and ...][as json]


Queries typically comprise three components:
 <field> - the name of a field.
           e.g. name, period, diet
 <operator> - how to compare the field to the value.
              e.g. >, <, ==, include?, start_with?
 <value> - the value to compare the field against.
           e.g. 2000, true, Cretaceous, North America

A negated comparison can be made by placing "not" or "!" before the operator
e.g. continent !include? America, name not start_with? Albert

Multiple criteria can be combined using "and"
e.g. weight <= 2000 and period != Early Cretaceous

One exception to the standard query format is with boolean fields.
You can test a boolean field is true by preceeding the field with
"is", "is not", "are", or "are not"'
e.g. is not carnivore? and period include? Cretaceous and name include? saur

Optionally, the results can be printed in JSON format by appending "as json"
to the end of a query.

eos

  TEXT_GOODBYE = <<-eos

Thank you for using the Dinodex!

eos

  TEXT_DATABASE_READY = <<-eos

The database is now ready to be queried.

eos

  TEXT_RESULTS = <<-eos

----------------
    Begin Query: %s

%s

    End Query: %s
----------------

eos

  TEXT_QUERY_PROMPT = <<-eos

Enter your query or a command: (use "help" or "?" for more info)

eos

  def command_help
    puts TEXT_HELP
    true
  end

  alias_method :command_?, :command_help

  def command_exit
    puts TEXT_GOODBYE
    false
  end

  alias_method :command_done, :command_exit
  alias_method :command_quit, :command_exit

  def parse_criteria(criteria)
    criteria.each do |criterium|
      segment = Criterium.new(criterium)
      yield(segment.to_hash)
    end
  end

  def check_commands(query)
    return unless ALLOWED_COMMANDS.include?(query)
    continue = send("command_#{query}")
    raise CommandException.new(continue: continue), "Command Found"
  end

  def parse_format(query)
    @format = query.match(/as json$/i) ? "json" : "s"
    query.gsub(/as json$/i, '')
  end

  def parse_query(query)
    parsed = parse_format(query)
    parsed.split(" and ")
  end

  def query_prompt
    puts TEXT_QUERY_PROMPT
    gets.chomp
  end

  def query
    query = query_prompt
    check_commands(query)
    criteria = parse_query(query)
    parse_criteria(criteria) { |filter_args| @dex.filter(filter_args) }
    puts format(TEXT_RESULTS, query, @dex.method("to_#{@format}").call, query)
  end

  def query_loop
    loop do
      begin
        query
      rescue CommandException => e
        break unless e.continue
      end
    end
  end

  def run
    @dex = Dinodex.new
    ImportLoop.new(@dex).run_loop
    query_loop
  end
end

app = DinodexApp.new
app.run
