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
    do_where(args)
    self
  end

  def limit(limit)
    limit = limit.to_it unless limit.is_a? Fixnum

    query[:limit] = limit
    @data = @data.first(limit)
    self
  end

  def sort(on_key)
    on_key = on_key.to_sym unless on_key.is_a? Hash
    query[:sort] = on_key
    do_sort(on_key)
    self
  end

  def pretty
    tp @data, object_keys(@data[0])
  end

  def to_json
    @data.map { |x| x.to_json }
  end

  private

  def do_where(args)
    @data = @data.map do |x|
      x_hash = object_to_hash(x) unless x.is_a? Hash
      matches = 0
      args.each { |key, val| matches += 1 if match?(x_hash[key.to_sym], val) }
      x if matches == args.keys.length
    end.compact
  end

  def match?(data_val, arg_val)
    if arg_val.is_a? Hash
      operation(data_val, arg_val)
    elsif arg_val.is_a? Array
      arg_val.map { |v| operation(data_val, '==' => v) }.include?(true)
    else
      operation(data_val, '==' => arg_val)
    end
  end

  def operation(data_val, arg_val)
    operator = arg_val.keys[0]

    return false unless data_val && ACCEPTED_OPERATORS.include?(operator)
    comparator = arg_val[operator]
    data_val.send(operator, comparator)
  end

  def do_sort(on_key)
    @data = @data.map { |x| object_to_hash(x) }.sort_by do |hsh|
      hsh[on_key]
    end
  end

  def object_to_hash(o)
    hash = {}
    o.instance_variables.each do |key|
      hash[key.to_s.delete("@").to_sym] = o.instance_variable_get(key)
    end
    hash
  end

  def object_keys(o)
    o.instance_variables.map do |key|
      key.to_s.delete("@")
    end
  end

  ACCEPTED_OPERATORS = ['<', '>', '>=', '<=', '==']
end
