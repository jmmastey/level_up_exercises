require 'table_print'

class QueryChainer
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def query
    @query ||= {}
  end

  def where(args)
    query[:where] = query[:where] ? query[:where].merge!(args) : args
    @data = data.select { |item| matches_all?(item, args) }
    self
  end

  def limit(limit)
    limit = limit.to_i unless limit.is_a? Fixnum
    query[:limit] = limit
    @data = data.first(limit)
    self
  end

  def sort(sort_key)
    query[:sort] = sort_key.to_sym
    @data = data.sort_by { |item| item.send(query[:sort]) }
    self
  end

  def pretty
    tp data, headers
  end

  def to_json
    data.map(&:to_json)
  end

  private

  def matches_all?(entry, args)
    raise NoMethodError unless columns_exist?(args.keys)
    args.all? { |field, criteria| matches?(entry.send(field), criteria) }
  rescue NoMethodError
    false
  end

  def matches?(field, criteria)
    if criteria.is_a? Array
      criteria.include?(field)
    else
      criteria = { '==' => criteria } unless criteria.is_a? Hash
      criteria.all? { |op, value| field.send(op, value) }
    end
  end

  def headers
    data[0].instance_variables.map { |key| key.to_s.delete("@") }
  end

  def columns_exist?(columns)
    columns = columns.map(&:to_s)
    (headers & columns).length == columns.length
  end
end
