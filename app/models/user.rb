class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :favorite_artists, through: :favorites, source: :artist
end
