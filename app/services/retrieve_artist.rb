class RetrieveArtist
  attr_accessor :artist_params

  def initialize(name)
    @artist_params = get_artist_data(name)
  end

  def get_artist_data(name)
    ArtsyApiWrapper.get_artist(name)
  end

  def update_artist_record
    if new_record?
      create_new_artist
    else
      ## Update artist
    end
  end

  def new_record?
    id = artist_params["id"]
    if Artist.find_by(api_id: id)
      false
    else
      true
    end
  end

  def create_new_artist
    first_name, last_name = artist_params["name"].split(' ')
    params = Hash.new
    params[:artist] = {
      api_id: artist_params["id"],
      first_name: first_name,
      last_name: last_name,
      biography: artist_params["biography"],
      nationality: artist_params["nationality"],
      birthday: artist_params["birthday"],
      analysis: artist_params["blurb"]
    }
    Artist.create(params[:artist])
  end
end
