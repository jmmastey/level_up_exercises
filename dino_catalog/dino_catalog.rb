require 'csv'



class DinoCatalog

  def initialize
    dinodex = CSVHelper.load_csv("dinodex.csv")
    african = CSVHelper.load_csv("african_dinosaur_export.csv")
    @data = merge_data(dinodex, african)
  end

  def grab_bipeds
    search( {:walking => "Biped"} )
  end

  def grab_carnivores 
    search( {:carnivore => true})
  end

  # def grab

  def search(filters)
    result = []
    @data.each do |entry|
      filters.each do |key, value|
        result << entry if entry[key] == value
      end
    end
  end

  # dinodex: name, period, continent, diet, weight_in_lbs, walking, description
  # african: genus, period, carnivore, weight, walking
  # merged: name, period, continent, diet, carnivore, weight, walking, description 
  def merge_data(dinodex, african)
    merged = []
    dinodex.each { |entry| merged << normalize_dinodex_entry(entry) }
    african.each { |entry| merged << normalize_african_entry(entry) }
    merged
  end

  def normalize_dinodex_entry(entry)
    {
        :name => entry[:name],
        :period => entry[:period],
        :continent => entry[:continent],
        :diet => entry[:diet],
        :carnivore => get_carnivore_for_dinodex(entry[:diet]),
        :weight => entry[:weight_in_lbs],
        :walking => entry[:walking],
        :description => entry[:description],
    }
  end

  def normalize_african_entry(entry)
    {
      :name => entry[:genus],
      :period => entry[:period],
      :continent => nil,
      :diet => nil,
      :carnivore => (entry[:diet] == "Yes"),
      :weight => entry[:weight],
      :walking => entry[:walking],
      :description => nil
    }
  end 

  def get_carnivore_for_dinodex(diet)
    (["Carnivore", "Pescivore", "Insectivore"].include? diet)
  end
end


module CSVHelper
  CSV::Converters[:blank_to_nil] = lambda do |field|
    field && field.empty? ? nil : field
  end

  def CSVHelper.load_csv(filename)
    f = File.open(filename, "r")
    data = CSV.new(f, :headers => true, :header_converters => :symbol, :converters => [:all, :blank_to_nil])
    data.to_a.map {|row| row.to_hash }
  end
end

catalog = DinoCatalog.new
puts catalog.search ({:carnivore => true})
puts catalog.search ({:carnivore => false})