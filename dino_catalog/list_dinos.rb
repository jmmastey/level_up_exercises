require_relative 'commands.rb'
require_relative 'input_parser.rb'

class ListDinos
  LISTMAP = {
    "-c"  => "continent",
    "-c?" => "carnivore?",
    "-d"  => "diet",
    "-i"  => "info",
    "-n"  => "name",
    "-p"  => "period",
    "-l"  => "locomotion",
    "-s"  => "size",
    "-w"  => "weight",
  }

  FLAGS = %w(-c -c? -d -f -i -l -n -p -s -w)

  public

  def initialize(registry)
    @registry = registry
    @input = InputParser.new
  end

  def evaluate(params)
    flags = @input.extract_flags(params)
    flags.each do |flag|
      return puts Commands.err_flag(flag) unless FLAGS.include?(flag.first)
    end
    parse(flags)
  end

  private

  def display_results(flags, full)
    method = full ? "properties_string" : "name"
    list = filtered_list(flags)
    return puts "\n> No matches found!\n\n" if list.empty?
    puts results(list, method)
  end

  def extract_full_flags(flags)
    full_flags = flags.find_all { |flag| flag.first == "-f" }.uniq
    flags -= full_flags
    [full_flags, flags]
  end

  def filtered_list(flags)
    return @registry.list if flags.empty?
    filter_list(flags)
  end

  def filter_list(flags)
    flags.reduce([]) do |memo, flag|
      filtered = @registry.find_all(flag.first, flag.last)
      next filtered if memo.empty?
      memo & filtered
    end
  end

  def flags_to_keys(flags)
    flags.map do |flag|
      key = LISTMAP[flag.first]
      next [key, flag.last] if key
      flag
    end
  end

  def parse(flags)
    full_flags, flags = extract_full_flags(flags)
    flags = flags_to_keys(flags)
    flags =  false if flags.empty?
    display_results(flags, full_flags.size > 0)
  end

  def results(list, method)
    list.reduce("\n") do |memo, instance|
      memo + instance.send(method) + "\n"
    end + "\n"
  end
end
