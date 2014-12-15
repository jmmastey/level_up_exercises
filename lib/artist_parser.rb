module ArtistParser
  def self.parse(data)
    ActiveSupport::JSON.decode(data.to_s)
  end
end
