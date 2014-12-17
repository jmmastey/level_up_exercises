class RetrieveArtist
  attr_accessor :artist_params

  def initialize(name)
    @artist_params = get_artist_data(name)
    update_artist_record
  end

  def update_artist_record
    if new_record?
      create_new_artist
    else
      update_artist
    end
  end

  private

  def get_artist_data(name)
    ArtsyApiWrapper.get_artist(name)
  end

  def params
    first_name = artist_params["name"].split(' ')[0]
    last_name = artist_params["name"].split(' ')[1..-1].join(' ')
    params = Hash.new
    params[:artist] = {
      api_id: artist_params["id"],
      first_name: first_name,
      last_name: last_name,
      biography: artist_params["biography"],
      nationality: artist_params["nationality"],
      birthyear: artist_params["birthday"],
      analysis: artist_params["blurb"]
    }
  end

  def artist
    id = artist_params["id"]
    Artist.find_by(api_id: id)
  end

  def new_record?
    if artist
      false
    else
      true
    end
  end

  def create_new_artist
    Artist.create(params)
  end

  def update_artist
    artist.update(params)
  end
end
