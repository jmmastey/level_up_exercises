require_relative 'dino'
require_relative 'util/commands'

require 'optparse'

class DinoLister
  def initialize(data_array)
    @dinos = dinos(data_array)
  end

  def evaluate(params)
    params = params.split(' ')
    options, full_flag = parse!(params)

    return results(options, full_flag) if params.empty?
    Commands.err_params(params)
  rescue OptionParser::InvalidOption => e
    Commands.err_flag(e.to_s.gsub(/invalid\soption:\s/, ''))
  rescue OptionParser::MissingArgument => e
    Commands.err_arg(e.to_s.gsub(/missing\sargument:\s/, ''))
  end

  private

  def dinos(data)
    data.map do |opts|
      dino = Dino.new
      opts.each { |opt| dino.send(opt.first + '=', opt.last) }
      dino
    end
  end

  def filtered_list(options)
    return @dinos if options.empty?
    options.inject(@dinos) do |memo, opt|
      filtered = find_all(opt.first, opt.last)
      memo & filtered
    end
  end

  def find_all(key, match_str)
    @dinos.each_with_object([]) do |instance, memo|
      val = instance.send(key).to_s
      memo << instance if str_contains?(val, match_str)
    end
  end

  def parse!(params)
    options = {}
    full_flag = false

    opt_parser = OptionParser.new do |opts|
      opts.on('-c STR') { |s| options["continent"] = s.downcase }
      opts.on('-d STR') { |s| options["diet"] = s.downcase }
      opts.on('-i STR') { |s| options["info"] = s.downcase }
      opts.on('-h STR') { |s| options["herbivore"] = s.downcase }
      opts.on('-l STR') { |s| options["locomotion"] = s.downcase }
      opts.on('-n STR') { |s| options["name"] = s.downcase }
      opts.on('-p STR') { |s| options["period"] = s.downcase }
      opts.on('-s STR') { |s| options["size"] = s.downcase }
      opts.on('-w STR') { |s| options["weight"] = s.downcase }

      opts.on('-f') { |b| full_flag = b }
    end

    opt_parser.parse!(params)
    [options, full_flag]
  end

  def results(options, full_flag)
    method = full_flag ? 'synopsis' : 'name'
    list = filtered_list(options)
    results_string(list, method)
  end

  def results_string(list, method)
    return "\n> No matches found!\n\n" if list.empty?
    list.inject("\n") do |memo, instance|
      memo + instance.send(method).to_s + "\n"
    end + "\n"
  end

  def str_contains?(search_str, match_str)
    return false unless search_str && match_str
    search_str.downcase.include?(match_str.downcase)
  end
end
