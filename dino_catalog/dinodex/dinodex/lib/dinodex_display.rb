require "dinosaur"
require "dinodex_filter"

module DinodexDisplay
  def filter_and_json(criteria)
    dinosaurs = @dinodex_filter.get_filtered_list(@dinosaurs, criteria)
    @output.puts JSON.dump(dinosaurs)
  rescue ArgumentError => e
    @output.puts e.message
  end

  def filter_and_detail(criteria)
    @dinodex_filter.get_filtered_list(@dinosaurs, criteria).each do |dinosaur|
      detail_display(dinosaur)
    end
  rescue ArgumentError => e
    @output.puts e.message
  end

  def filter_and_display(criteria)
    list_display(@dinodex_filter.get_filtered_list(@dinosaurs, criteria))
  rescue ArgumentError => e
    @output.puts e.message
  end

  def filter_and_display_name(name)
    filter_and_detail("name=#{name}")
  end

  def detail_display(dinosaur)
    @output.puts dinosaur.name
    @output.puts "Period: #{dinosaur.period}" unless dinosaur.period.nil?
    @output.puts "Diet: #{dinosaur.diet}" unless dinosaur.diet.nil?
    @output.puts "Walking: #{dinosaur.walking}" unless dinosaur.walking.nil?
    unless dinosaur.description.nil?
      @output.puts "Description: #{dinosaur.description}"
    end
    unless dinosaur.continent.nil?
      @output.puts "Continent: #{dinosaur.continent}"
    end
  end

  def detail_display_by_name(name)
    dinosaur = @dinosaurs.select do |dino|
      dino.name.downcase == name.downcase
    end[0]
    if dinosaur.nil?
      @output.puts "Dinosaur with name '#{name}' not found."
    else
      detail_display(dinosaur)
    end
  end

  def list_display(dinosaurs = @dinosaurs)
    dinosaurs.each do |dinosaur|
      @output.puts dinosaur.name
    end
  end
end
