class DataAggregator
  attr_reader :grooveshark

  DEFAULTS = {
    top_song_limit: 10
  }

  def initialize
    @grooveshark = Grooveshark::Client.new
  end

  def store_todays_chart(scope = "daily")
    chart = Chart.new(scope: scope)
    chart.save

    songs = []

    get_popular_songs(scope: scope).each do |song|
      artist = Artist.find_or_create_by(name: song.artist, grooveshark_id: song.artist_id.to_i)
      song = Song.find_or_create_by(name: song.name, grooveshark_id: song.id.to_i, artist: artist)

      songs << song
    end

    chart.songs = songs
  end

  def get_popular_songs(options = {})
    limit = options[:limit] || DEFAULTS[:top_song_limit]
    scope = options[:scope] || "daily"

    grooveshark.popular_songs(scope).take(limit)
  end
end
