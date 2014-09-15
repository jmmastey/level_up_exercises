require "dinosaur"
require "dinodex_filter"

module DinodexDisplay
  def list_display(dinosaurs = @dinosaurs)
    dinosaurs.each do |dinosaur|
      @output.puts dinosaur.name
    end
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

  def filter_and_json(criteria)
    dinosaurs = @filter.get_filtered_list(@dinosaurs, criteria)
    @output.puts JSON.dump(dinosaurs)
  rescue ArgumentError => e
    @output.puts e.message
  end

  def filter_and_detail(criteria)
    @filter.get_filtered_list(@dinosaurs, criteria).each do |dinosaur|
      detail_display(dinosaur)
    end
  rescue ArgumentError => e
    @output.puts e.message
  end

  def filter_and_display(criteria)
    list_display(@filter.get_filtered_list(@dinosaurs, criteria))
  rescue ArgumentError => e
    @output.puts e.message
  end

  def filter_and_display_name(name)
    filter_and_detail("name=#{name}")
  end

  def detail_display_by_name(name)
    dinosaur = @filter.get_filtered_list(@dinosaurs, "name=#{name}")[0]
    if dinosaur.nil?
      @output.puts "Dinosaur with name '#{name}' not found."
    else
      detail_display(dinosaur)
    end
  end
end
