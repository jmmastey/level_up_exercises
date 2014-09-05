#!/usr/bin/env ruby

require "colorize"
require "json"
require "optparse"
require_relative "dinodex.rb"
require_relative "trace.rb"

class App
  def main
    init_index
    clear_screen
    welcome
    begin
      cmd = get_command
      exec_command cmd
    end until cmd[0] == "quit"
  end

  private

  @@valid_commands = [
    :add,
    :clear_screen,
    :help,
    :export,
    :import,
    :list,
    :quit
  ]

  def add(fields)
    @dinodex.add (JSON.parse fields)
    puts "Dinosaur added.".green
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

  def exec_command(cmd)
    if cmd.length > 0
      if @@valid_commands.include?(cmd[0].to_sym)
        begin
          send *cmd
        rescue Exception => e
          puts "Error encountered: #{e.message}".red
        end
      else
        method_missing cmd[0]
      end
    end
  end

  def export(filename, *search_params)
    File.write filename, search(*search_params).to_json
    puts "File written.".green
  end

  def flag_big(index)
    index.find_with_min_weight! 2000
    Trace["Index filtered by weight (big)"]
  end

  def flag_biped(index)
    index.find! walking: "Biped"
    Trace["Index filtered by bipeds"]
  end

  def flag_carnivore(index)
    index.find_carnivore!
    Trace["Index filtered by carnivores"]
  end

  def flag_fields(index, field_assigns)
    field_assigns.each do |field_assign|
      split_value = field_assign.split("=")
      name = split_value[0]
      value = split_value[1]
      index.find! name => value
      Trace["Index filtered by field #{name}=#{value}"]
    end
  end

  def flag_period(index, name)
    index.find_in_period! name
    Trace["Index filtered by period #{name}"]
  end

  def flag_small(index)
    index.find_with_max_weight! 1999
    Trace["Index filtered by weight (small)"]
  end

  def get_command
    print ">> "
    # split command by spaces, grouping quotes and brackets
    cmd = gets.split /\s(?=(?:[^[\{\}]"]|"[^"]*"|\{[^[\{\}]]*\})*$)/
    puts
    cmd
  end

  def import(*filenames)
    filenames.each do |filename|
      @dinodex.load_csv filename
      puts "Loaded file \"#{filename}\"".green
    end
  end

  def init_index
    @dinodex = DinoDex.new
  end

  def help
    puts File.read("helptext.txt").cyan
  end

  def list(*search_params)
    puts search(*search_params).to_s.cyan
  end

  def method_missing(m, *_args, &_block)
    puts "Invalid command: #{m}".red
    puts
  end

  def search(*search_params)
    @filtered_index = @dinodex.clone
    Trace["Filtered index created."]

    opt_parser = OptionParser.new do |opts|
      opts.on("--big", "Excludes dinosaurs under 2 tons.") do
        flag_big @filtered_index
      end

      opts.on("--biped", "Includes only bipedal dinosaurs.") do
        flag_biped @filtered_index
      end

      opts.on("--carnivore", "Includes only carnivores.") do
        flag_carnivore @filtered_index
      end

      opts.on("--fields NAME=VALUE",
              Array,
              "Filters dinosaurs by the given fields.") do |field_assigns|
                flag_fields @filtered_index, field_assigns
              end

              opts.on("--period NAME", "Filters dinosaurs by period.") do |name|
                flag_period @filtered_index, name
              end

              opts.on("--small", "Includes only dinosaurs lighter than 2000 lbs.") do
                flag_small @filtered_index
              end
    end

    Trace["Parser created."]
    opt_parser.parse search_params
    Trace["Parser has parsed through #{search_params.count} parameters:"]
    search_params.each { |param| Trace["#{param}"] }

    @filtered_index
  end

  def quit
    puts "Thank you for using DinoDex.".yellow
    Trace["User exited program"]
    puts
  end

  def welcome
    puts ("*" * 80).yellow
    puts "DinoDex Interface".yellow
    puts ("*" * 80).yellow
    puts "Type 'help' for a list of available commands."
    puts
  end
end

# Uncomment the following line to enable trace mode:
# Trace.on
app = App.new
app.main
