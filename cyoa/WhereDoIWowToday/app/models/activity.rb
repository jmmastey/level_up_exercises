class Activity < ActiveRecord::Base
  validates_presence_of :character, :category, :quest
  validates_uniqueness_of :character, scope: [:category, :quest]
  belongs_to :character
  belongs_to :category
  belongs_to :quest
  has_many :owned_activity, dependent: :destroy

  def self.find_or_create(args)
    Activity.find_by(args) || Activity.create!(args)
  end

  def zone
    category if category.zone?
  end
end
