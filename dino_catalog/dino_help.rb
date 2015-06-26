require_relative "util/commands"

require 'json'

class DinoHelp
  CONFIG = "config/help.json"

  def initialize(config = CONFIG)
    @messages = help_messages(data_sources(config))
  end

  def evaluate(params)
    params = 'manual' unless params.size > 0
    return Commands.err_cmd(params) unless Commands.valid_cmd?(params)
    @messages[params]
  end

  private

  def help_messages(sources)
    sources.each_with_object({}) do |(key, val), memo|
      memo[key] = File.read(filepath(val))
    end
  end

  def data_sources(file)
    JSON.parse(File.read(filepath(file)))
  end

  def filepath(file)
    File.join(File.expand_path(File.dirname(__FILE__)), file)
  end
end
