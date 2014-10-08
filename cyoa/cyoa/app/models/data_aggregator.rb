class DataAggregator
  attr_reader :grooveshark

  DEFAULTS = {
    top_song_limit: 10
  }

  def initialize
    @grooveshark = Grooveshark::Client.new
  end

  def populate_charts
    update_chart_data("daily")
    update_chart_data("monthly")
    update_new_artist_api_ids
  end

  def update_artist_metrics
    artists = Artist.all
    artists.each do |artist|
    end
  end

  def get_artist_metrics(artist, start = 3.months.ago)
    NextBigSoundLite::Metric.artist(artist.id, start: start)
  end

  def update_chart_data(scope = "daily")
    chart = Chart.new(scope: scope)
    chart.save

    songs = []

    get_popular_songs(scope: scope).each_with_index do |gs_song, index|
      artist = Artist.find_or_create_by(name: gs_song.artist,
                                        grooveshark_id: gs_song.artist_id.to_i)
      song = Song.find_or_create_by(name: gs_song.name,
                                    grooveshark_id: gs_song.id.to_i,
                                    artist: artist)

      ChartSong.create(song: song,
                       chart: chart,
                       popularity: gs_song.data["popularity"].to_i,
                       position: index + 1)
    end
  end

  def get_popular_songs(options = {})
    limit = options[:limit] || DEFAULTS[:top_song_limit]
    scope = options[:scope] || "daily"

    grooveshark.popular_songs(scope).take(limit)
  end

  def update_new_artist_api_ids
    Artist.where(nbs_id: nil).each do |artist|
      artist.update_api_ids
    end
  end
end
