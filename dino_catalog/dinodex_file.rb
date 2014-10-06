require_relative "file_handler"
require_relative "dinosaur"

class DinodexFile < FileHandler
  def map_to_object(content)
    Dinosaur.new(content)
  end

  def header_converters
    CSV::HeaderConverters[:renaming] = lambda do |header|
      header = :weight if header == 'WEIGHT_IN_LBS'
      header.downcase.to_sym
    end
  end

  def content_converters
    CSV::Converters[:blank_to_nil] = lambda do |field|
      field && field.empty? ? nil : field
    end
  end
end
