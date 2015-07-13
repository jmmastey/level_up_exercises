require 'csv'

class DinoData

  @dino_data = []

  def self.add_to_catalog(data)
    data.by_row.each do |row|
      @dino_data << row
    end
  end

  def self.remove_from_catalog
    # probably not needed
  end

  def self.search_by_header(criteria)
    criteria = criteria.downcase.to_sym
    puts "Search by header:#{criteria}"
    @dino_data.each do |row|
      row if row.header?(criteria) && row.field(criteria)
    end
  end

  def self.search_by_field(criteria)
    puts "Search by field: #{criteria}"
    self.dino_data.each do |row|
      row if row.field?(criteria)
    end
  end

  # these methods don't really belong in this class
  def self.create_dinos
    @dino_data.each {|row| Dinosaur.new(row)}
  end

  def self.show_raw_data
    puts "dino_data is #{@dino_data}"
    #puts @dino_data
  end
end
