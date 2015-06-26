class Dino
  attr_accessor :name, :period, :continent,
    :diet, :weight, :locomotion, :info

  def size(threshhold = 4000)
    return '' unless @weight
    return 'big' if @weight.to_i > threshhold
    'small'
  end

  def synopsis
    full_string = properties.map do |prop|
      val = send(prop)
      val ? "#{prop.capitalize}: #{val}\n" : ""
    end.join('')
    full_string.gsub(/\s(\d+)$/, " #{pretty_weight}")
  end

  def herbivore
    @diet.downcase == 'herbivore'
  end

  private

  def pretty_weight
    weight_str = @weight.to_s
    weight_arr = weight_str.chars.to_a
    pretty_num = weight_arr.reverse.each_slice(3).map(&:join).join(",").reverse
    pretty_num + ' lbs'
  end

  def properties
    instance_variables.map { |ivar| ivar.to_s.sub(/^@/, '') }
  end
end
