require_relative 'dino_csv_cleaner'
require_relative 'hash'

class Dinosaur
  def initialize
  end

  def create_attribute(header)
    header.each do |h|
      instance_variable_set("@#{h}", nil)
      self.class.send(:attr_accessor, "#{h}")
    end
  end
end
