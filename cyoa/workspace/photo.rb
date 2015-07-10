class Photo
  attr_reader :first, :last, :photo_url

  def initialize(row)
    @first = row[:first]
    @last = row[:last]
    @photo_url = row[:photo_url]
  end
end
