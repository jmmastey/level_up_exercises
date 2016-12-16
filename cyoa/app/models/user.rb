require 'area'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_tags, dependent: :destroy
  has_many :tags, through: :user_tags
  has_many :bookmarks, dependent: :destroy
  has_many :bills, through: :bookmarks

  validate :valid_us_zipcode, on: :update

  def valid_us_zipcode
    region = zipcode.to_region
    errors.add(:zipcode, 'Zipcode must be a valid US zipcode') if region.nil?
  rescue ArgumentError
    errors.add(:zipcode, 'Zipcode must be a valid US zipcode')
  end

  def legislators_by_zipcode
    return [] unless zipcode
    LegislatorQuery.new(Legislator.all, zipcode).execute
  end
end
