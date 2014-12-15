class RetrieveArtist
  attr_accessor :artist_name, :nationality, :birthday, :biography, :analysis
  attr_reader :parsed_data

  def initialize(data)
    @parsed_data = parse_data(data)
    @artist_name = parse_name(data)
    @nationality = parse_nationality(data)
    @birthday = parse_birthday(data)
    @biography = parse_biography(data)
    @analysis = parse_analysis(data)
  end

  def parse_name(data)
    parsed_data["name"]
  end

  def parse_nationality(data)
    parsed_data["nationality"]
  end

  def parse_birthday(data)
    parsed_data["birthday"]
  end

  def parse_biography(data)
    parsed_data["biography"]
  end

  def parse_analysis(data)
    parsed_data["blurb"]
  end

  private

  def parse_data(data)
    JSON.parse(data)
  end
end
