class Dino
  attr_accessor :name, :period, :continent
  attr_accessor :diet, :weight, :locomotion, :info

  public

  def size
    if @weight
      @weight.to_i > 4000 ? 'big' : 'small'
    else
      ""
    end
  end

  def weight
    separate_comma(@weight) + ' lbs' if @weight
  end

  def properties_string
    instance_variables.map do |prop|
      prop_name = prop.to_s.gsub(/^@/, '')
      val = send(prop_name)
      val ? "#{prop_name.capitalize}: #{val}\n" : ""
    end.join('')
  end

  def properties_hash
    instance_variables.inject({}) do |hash, key|
      key = key.to_s.gsub(/^@/, '')
      hash[key] = send(key) if send(key)
      hash
    end
  end

  def <=>(other)
    name <=> other.name
  end

  private

  def separate_comma(num_string)
    num_string.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
  end
end
