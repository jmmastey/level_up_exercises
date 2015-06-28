require_relative 'util/commands'

require 'optparse'
require 'json'

class DinoExporter
  def initialize(dino_array)
    @data = JSON.pretty_generate(dino_array)
  end

  def export(params)
    params = params.split(' ')
    filename = parse!(params).gsub(/\.json$/, '') + '.json'

    return write_data(filename) if params.empty?
    Commands.err_params(params)
  rescue OptionParser::InvalidOption => e
    Commands.err_flag(e.to_s.gsub(/invalid\soption:\s/, ''))
  rescue OptionParser::MissingArgument => e
    Commands.err_arg(e.to_s.gsub(/missing\sargument:\s/, ''))
  end

  private

  def create_dir(path)
    return if Dir.exist?(path)
    Dir.mkdir(path, 0755)
  end

  def filepath(file)
    File.join(File.expand_path(File.dirname(__FILE__)), file)
  end

  def parse!(params)
    filename = "export"

    opt_parser = OptionParser.new do |opts|
      opts.on('-n FILENAME') { |n| filename = n }
    end

    opt_parser.parse!(params)
    filename
  end

  def write_data(filename, dirname = 'exports')
    create_dir(File.join(filepath(dirname)))
    fullpath = filepath(File.join(dirname, filename))
    File.open(fullpath, 'w') { |f| f.write(@data) }
    "\n> File successfully saved to #{fullpath}\n\n"
  end
end
