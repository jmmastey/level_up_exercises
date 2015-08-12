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
    @data = JSON.parse(IO.read(source), symbolize_names: true)
  end
end
