require 'json'

class DataLoader
  attr_reader :data

  def fetch(args)
    key, target = args.first
    op = args[:op] || "=="

    data.select do |i|
      i[key].method(op).call(target)
    end
  end

  def initialize(source)
    @data = JSON.parse(File.read(source[:file]),
                       symbolize_names: true) if source[:file]
    @data = source[:data] if source[:data]
    raise ArgumentError, "No source data provided" unless @data
    raise ArgumentError, "No data provided" unless @data.size > 0
    raise ArgumentError, "Malformed data provided" unless @data[0].is_a?(Hash)
  end
end
