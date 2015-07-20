class Dino
  ATTRIBUTES = %w(name period continent diet weight walking description)

  attr_accessor *ATTRIBUTES

  def initialize(data)
    data.keys.each do |attr|
      send("#{attr}=", data[attr])
    end
  end

  def properties
    Hash[ATTRIBUTES.map { |attr| [attr, send(attr)] }]
  end

  def to_s
    properties.each.inject("") do |str, tuple|
      fattr = "#{tuple[0].capitalize}:".ljust(20)
      fval = tuple[1].nil? ? '---' : tuple[1]

      str << "#{fattr}#{fval}\n"
    end
  end

  def compare(field, with)
    myval = send(field)
    if !(myval && with)
      myval.__id__ <=> with.__id__
    elsif field == 'weight'
      myval.to_i <=> with.to_i
    else
      myval.downcase <=> with.downcase
    end
  end

  def like?(field, value)
    myval = send(field)
    if myval.nil? || value.nil?
      myval.nil? && value.nil?
    else
      !!(myval.downcase =~ /#{value.downcase}/)
    end
  end

  def less_than?(field, value)
    compare(field, value) < 0
  end

  def greater_than?(field, value)
    compare(field, value) > 0
  end

  def equal?(field, value)
    compare(field, value) == 0
  end

  def less_or_equal?(field, value)
    !greater_than?(field, value)
  end

  def greater_or_equal?(field, value)
    !less_than?(field, value)
  end

  def not_equal?(field, value)
    !equal?(field, value)
  end

  def not_like?(field, value)
    !like?(field, value)
  end
end
