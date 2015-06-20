class Dino
  attr_accessor :name, :period, :continent
  attr_accessor :diet, :weight, :locomotion, :info

  public

  def size
    return '' unless @weight
    return 'big' if @weight.to_i > 4000
    'small'
  end

  def weight
    separate_comma(@weight) + ' lbs' if @weight
  end

  def details
    instance_variables.map do |prop|
      prop_name = prop.to_s.gsub(/^@/, '')
      val = send(prop_name)
      val ? "#{prop_name.capitalize}: #{val}\n" : ""
    end.join('')
  end

  def carnivore?
    (@diet.downcase != 'herbivore').to_s
  end

  def <=>(other)
    name <=> other.name
  end

  private

  def separate_comma(num_string)
    num_string.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
  end
end
