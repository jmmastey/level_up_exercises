require "dinosaur"

class DinodexFilter

  def get_filtered_list(dinosaurs, criteria)
    criteria.split("|").each do |criteria|
      comparison = criteria[/[<>=]/]
      key, value = criteria.split(/[<>=]/)

      raise_if_invalid(key, value)

      filter(comparison, dinosaurs, key, value)
    end
    dinosaurs
  end

  private

  def raise_if_invalid(key, value)
    if !Dinosaur.method_defined?(key)
      raise(ArgumentError, "Invalid dinosaur attribute '#{key}' used")
    end

    if value.nil?
      raise(ArgumentError, "Empty value for '#{key}' used")
    end
  end

  def filter(comparison, dinosaurs, key, value)
    case comparison
      when "="
        dinosaurs.select! do |dinosaur|
          dinosaur.send(key).nil? ? false : (dinosaur.send(key).downcase.include? (value.downcase))
        end
      when "<"
        dinosaurs.select! do |dinosaur|
          if dinosaur.send(key).nil?
            false
          else
            dinosaur.send(key).to_i < value.to_i
          end
        end
      when ">"
        dinosaurs.select! do |dinosaur|
          if dinosaur.send(key).nil? then
            false
          else
            dinosaur.send(key).to_i > value.to_i
          end
        end
    end
  end

end