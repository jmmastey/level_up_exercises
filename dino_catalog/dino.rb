class Dino
  attr_accessor :attrs

  def initialize(data)
    keys = %w(name period continent diet weight walking description)
    @attrs = Hash[keys.zip([nil] * keys.count)]
    @attrs.merge!(data)
  end

  def dino_facts
    @attrs.each do |attribute, value|
      fattr = "#{attribute.capitalize}:".ljust(20)
      fval = value.nil? ? '---' : value
      puts "#{fattr}#{fval}"
    end
    puts
  end

  def compare(field, with)
    myval = attrs[field]
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
    myval = attrs[field]
    if myval.nil? || value.nil?
      (myval.nil? && value.nil?)
    else
      myval.downcase =~ /#{value.downcase}/
    end
  end
end
