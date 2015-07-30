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

  # def create_method(name, &block)
  #   self.class.send(:define_method, name, &block )
  # end

  # def create_attribute(name)
  #   create_method("#{name}=".to_sym) { |val|
  #     instance_variable_set( "@" + name, val)
  #   }
  #   create_method( name.to_sym ){
  #     instance_variable_get( "@" + name )
  #   }
  # end

  # def create_attr(header)
  #   header.each do |attri|
  #     create_attribute(attri)
  #   end
  # end
end

