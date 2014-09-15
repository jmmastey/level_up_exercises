require "dinosaur"

class DinodexFilter
  def get_filtered_list(dinosaurs, criteria)
    raise(ArgumentError, "Criteria not specified") if criteria.nil?
    criteria.split("|").each do |criterion|
      comparison = criterion[/[<>=]/]
      key, value = criterion.split(/[<>=]/)

      raise_if_invalid(key, value)

      filter(comparison, dinosaurs, key, value)
    end
    dinosaurs
  end

  private

  def raise_if_invalid(key, value)
    raise(ArgumentError, "Empty value for '#{key}' used") if value.nil?

    invalid_msg = "Invalid dinosaur attribute '#{key}' used"
    raise(ArgumentError, invalid_msg) unless Dinosaur.method_defined?(key)
  end

  def filter(comparison, dinosaurs, key, value)
    filter_map = { "=" => :filter_equals?,
                   "<" => :filter_less_than?,
                   ">" => :filter_greater_than?
    }
    unless filter_map[comparison]
      raise(ArgumentError, "Invalid comparison operator #{comparison}")
    end
    dinosaurs.select! do |dinosaur|
      send(filter_map[comparison], dinosaur, key, value)
    end
  end

  def filter_greater_than?(dinosaur, key, value)
    dinosaur.send(key).to_i > value.to_i
  end

  def filter_less_than?(dinosaur, key, value)
    dinosaur.send(key).to_i < value.to_i
  end

  def filter_equals?(dinosaur, key, value)
    dinosaur.send(key).downcase.include?(value.downcase)
  end
end
