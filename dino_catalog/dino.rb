class Dino
  ATTRIBUTES = %w(name period continent diet weight walking description)

  attr_accessor :name, :period, :continent
  attr_accessor :diet, :weight, :walking, :description

  def initialize(data)
    data.keys.each do |attr|
      send("#{attr}=", data[attr])
    end
  end

  def properties
    ATTRIBUTES.map { |attr| [attr, send(attr)] }
  end

  def dino_facts
    properties.each do |attr, val|
      fattr = "#{attr.capitalize}:".ljust(20)
      fval = val.nil? ? '---' : val
      puts "#{fattr}#{fval}"
    end
    puts
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

  def less_than?(field, value)
    compare(field, value) < 0
  end

  def greater_than?(field, value)
    compare(field, value) > 0
  end

  def equal?(field, value)
    compare(field, value) == 0
  end

  def like?(field, value)
    myval = send(field)
    if myval.nil? || value.nil?
      myval.nil? && value.nil?
    else
      myval.downcase =~ /#{value.downcase}/
    end
  end
end
