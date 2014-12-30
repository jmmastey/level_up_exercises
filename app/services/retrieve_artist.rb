class RetrieveArtist
  attr_accessor :artist_params

  def initialize(name)
    begin
      @artist_params = ArtsyApiWrapper.get_artist(name)
    rescue Faraday::ResourceNotFound
      @artist_params = nil
    end
  end

  def update_record
    if new_record?
      create_new_artist
      create_artworks
    else
      update_artist
    end
  end

  def new_record?
    if artist
      false
    else
      true
    end
  end

  def record_exist?
    @artist_params
  end

  private

  def params
    first_name = artist_params['name'].split(' ')[0]
    last_name = artist_params['name'].split(' ')[1..-1].join(' ')
    params = Hash.new
    params[:artist] = {
      api_id: artist_params['id'],
      first_name: first_name,
      last_name: last_name,
      biography: artist_params['biography'],
      nationality: artist_params['nationality'],
      birthyear: artist_params['birthday'],
      analysis: artist_params['blurb'],
      thumbnail: artist_params["_links"]["thumbnail"]["href"]
    }
  end

  def artist
    id = artist_params['id']
    Artist.find_by(api_id: id)
  end

  def url
    artist_params["_links"]["artworks"]["href"]
  end

  def create_new_artist
    Artist.create(params)
  end

  def update_artist
    artist.update(params)
  end

  def create_artworks
    RetrieveArtworks.new(url, artist)
  end
end
