class Activity < ActiveRecord::Base
  validates_presence_of :character, :category
  validates_uniqueness_of :character, scope: [:category, :quest]
  belongs_to :character
  belongs_to :category
  belongs_to :quest

  def zone
    category if category.zone?
  end

  def self.find_or_create(args)
    Activity.find_by(args) || Activity.create!(ensure_hidden_is_set(args))
  end

  def self.ensure_hidden_is_set(args)
    args[:hidden] = false unless args.key?(:hidden) && !args[:hidden].empty?
    args
  end
  private_class_method :ensure_hidden_is_set
end
