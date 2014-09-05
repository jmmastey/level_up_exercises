#!/usr/bin/env ruby
# File dinosaur.rb
class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight,
                :walking, :description
  HEADERS = %w(Name Period Continent Diet Weight Walking Description)

  def self.fields
    fields = []
    HEADERS.each { |field| fields << field.downcase }
    fields
  end

  def initialize(options = {})
    options.each do |var, value|
      begin
        method("#{var}=").call(value)
      rescue
        match = var.to_s.match(/^weight/)
        method(:weight=).call(value) if match
      end
    end
  end

  attr_writer :weight

  def table_display
    data    = []
    headers = instance_variables.reduce([]) do |result, item|
      result << item.to_s
      data << instance_variable_get(item)
      result
    end
    Hirb::Helpers::AutoTable.render(data, headers: headers)
  end

  def to_s
    "#{name}"
  end

  def inspect
    instance_variables.reduce([
      "\n#Dinosaur: #{name}",
      "\tInformation:"
    ]) do |result, item|

      result << "\t\t#{item} = #{instance_variable_get(item)}"
      result
    end.join("\n")
  end
end
