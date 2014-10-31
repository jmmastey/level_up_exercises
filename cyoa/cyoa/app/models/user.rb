class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
       # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :artists, uniq: true

  after_create :set_defaults

  def remove_artist(artist)
    artists.delete(artist)
  end

  def add_artist_name(artist_name)
    artist = Artist.find_or_create_by_unique_name(artist_name)
    artists << artist unless artists.include? artist
    artist.nbs_id
  end

  def nbs_artists
    artists.where.not("nbs_id" => nil)
  end

  private

  def set_defaults
    artists << Artist.defaults
  end
end
