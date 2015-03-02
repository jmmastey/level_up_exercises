class DataGenerator
  def self.last_name
    last_names.sample
  end

  def self.last_names
    @last_names ||= File.new("lastnames.txt").map(&:chomp)
  end

  def self.first_name
    first_names.sample
  end

  def self.first_names
    @first_names ||= File.new("firstnames.txt").map(&:chomp)
  end

  def self.beer_style
    beer_styles.sample
  end

  def self.beer_styles
    @beer_styles ||= File.new("beerstyles.txt").map(&:chomp)
  end

  def self.beer_rating
    rand(1..10)
  end
end
