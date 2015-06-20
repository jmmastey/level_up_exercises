require 'json'

class Registry
  attr_reader :list

  public

  def initialize(wrapperclass)
    @list = []
    @wrapperclass = wrapperclass
  end

  def register_all(configs)
    configs.each { |config| register(config) }
  end

  def register(config)
    @list << create_class(config)
  end

  def find_all(key, match_str)
    @list.inject([]) do |memo, instance|
      val = instance.send(key)
      match = [instance] if str_contains?(val, match_str)
      memo + (match || [])
    end
  end

  def json
    arr = @list.sort.inject([]) do |memo, instance|
      memo + [obj_to_hash(instance)]
    end
    JSON.pretty_generate(arr)
  end

  private

  def create_class(config)
    instance = @wrapperclass.new
    config.each do |key, val|
      instance.send(key + '=', val) if val
    end
    instance
  end

  def str_contains?(search_str, match_str)
    return false unless search_str && match_str
    search_str.downcase.include?(match_str.downcase)
  end

  def obj_to_hash(instance)
    instance.instance_variables.each_with_object({}) do |key, memo|
      val = instance.instance_variable_get(key)
      memo[key.to_s.delete('@')] = val
    end
  end
end
