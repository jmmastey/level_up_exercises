class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight_in_lbs, :walking,
                :description, :genus, :carnivore

  def initialize(args = {})
    args.each_pair do |key, value|
      send("#{key}=", value)
    end
  end

  def carnivore?
    %w(Carnivore Piscivore Insectivore).include?(diet) || carnivore == "Yes"
  end

  def biped?
    walking == "Biped"
  end

  def big?
    weight_in_lbs > 4480
  end

  def small?
    !big?
  end

  def print_facts
    instance_variables.each do |attr|
      value = instance_variable_get(attr)
      puts "#{attr}: #{value}" unless value.nil?
    end
    nil
  end

  def self.print(dinos)
    dinos.each(&:print_facts)
  end

  def self.partition_by_period(dinosaurs)
    grouped_dinos = dinosaurs.group_by(&:period)
    grouped_dinos["Cretaceous"] = grouped_dinos.delete("Early Cretaceous") +
                                  grouped_dinos.delete("Late Cretaceous")
  end
end
