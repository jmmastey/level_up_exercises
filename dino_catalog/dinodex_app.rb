class DinodexApp
  attr_accessor :io
  attr_accessor :filter
  attr_accessor :merger

  def initialize(io, filter, merger)
    @io = io
    @filter = filter
    @merger = merger
  end

  def read(file)
    @io.read(file)
  end

  def write(data)
    @io.write(data)
  end

  def filter(data, options)
    @filter.filter_data(data, options)
  end

  def filter_columns(data, columns)
    @filter.filter_columns(data, columns)
  end

  def merge_data(data1, data2, column_mapping)
    @merger.merge_data(data1, data2, column_mapping)
  end
end
