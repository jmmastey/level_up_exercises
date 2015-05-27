$LOAD_PATH << '.'
require 'dinosaur'



class Dinosaur_Catalog
  attr_reader :dinosaurs

  #Auto Load dinosaurs DB
  def initialize(dinosaurs)
    @dinosaurs = dinosaurs
  end

  def filter(hash)
    if hash.length > 0
      k, v = hash.shift
        if k.to_s == "period"
           return self.send(k,v).filter(hash)
         elsif v == true
           return self.send(k).filter(hash)
         else
           puts "Invalid filter: " + k.to_s + ": " + v.to_s + " bypassing filter..."
           return self.filter(hash)
         end
       else
         return self
       end

  end

  def bipeds
    value = []
    @dinosaurs.each do |item|
      if item.walking.chomp == "Biped" && !item.walking.empty?
        value.push(item)
      end
    end
    return Dinosaur_Catalog.new(value)
  end

  def carnivores
    value = []
    @dinosaurs.each do |item|
      puts item.facts
      if item.diet == "Carnivore" && !item.diet.empty?
        value.push(item)
      end
      if item.carnivore == "Yes" && !item.carnivore.empty?
        value.push(item)
      end
    end
    return Dinosaur_Catalog.new(value)
  end

  def period(str)
    value = []
    @dinosaurs.each do |item|
      if str.downcase.chomp.include? item.period.downcase.chomp && !item.period.empty?
        value.push(item)
      end
    end
    return Dinosaur_Catalog.new(value)
  end

  def big
    value = []
    @dinosaurs.each do |item|
      if item.weight.to_i > 4000 && !item.weight.empty?
        value.push(item)
      end
    end
    return Dinosaur_Catalog.new(value)
  end

  def small
    value = []
    @dinosaurs.each do |item|
      if item.weight.to_i <= 4000 && !item.weight.empty?
        value.push(item)
      end
    end
    return Dinosaur_Catalog.new(value)
  end

  def facts
    @dinosaurs.each do |item|
      item.facts
    end
    return Dinosaur_Catalog.new(@dinosaurs)
  end

  def print
    @dinosaurs.each do |item|
      item.print
    end
    return Dinosaur_Catalog.new(@dinosaurs)
  end
end
