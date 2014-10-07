class DataAggregator
  attr_reader :grooveshark

  DEFAULTS = {
    top_song_limit: 10
  }

  def initialize
    @grooveshark = Grooveshark::Client.new
    NextBigSoundLite.api_key = "colleensain"
  end

  def populate_charts
    store_current_chart("daily")
    store_current_chart("monthly")
  end

  def gather_metrics_for_artists
  end

  private

  def store_current_chart(scope = "daily")
    chart = Chart.new(scope: scope)
    chart.save

    songs = []

    get_popular_songs(scope: scope).each do |song|
      artist = Artist.find_or_create_by(name: song.artist,
                                        grooveshark_id: song.artist_id.to_i)
      song = Song.find_or_create_by(name: song.name,
                                    grooveshark_id: song.id.to_i,
                                    artist: artist)

      ChartSong.create(song: song, chart: chart, popularity: song.popularity)
    end
  end

  def get_popular_songs(options = {})
    limit = options[:limit] || DEFAULTS[:top_song_limit]
    scope = options[:scope] || "daily"

    grooveshark.popular_songs(scope).take(limit)
  end

  public

  def metric_for_artist(id, start = 3.months.ago)
    NextBigSoundLite::Metric.artist(id, start: start)
  end

  def store_nbs_ids_for_artists
    artists = Artist.where(nbs_id: nil)
    artists.each do |artist|
      search_results = NextBigSoundLite::Artist.search(artist.name)

      if search_results
        nbs_id = search_results.first.id.to_i
        artist.nbs_id = nbs_id

        artist.save
      end
    end
  end
end
