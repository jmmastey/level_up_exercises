class Activity < ActiveRecord::Base
  validates_presence_of :character, :category, :quest
  validates_uniqueness_of :character, scope: [:category, :quest]
  belongs_to :character
  belongs_to :category
  belongs_to :quest
  has_and_belongs_to_many :owned_activity

  def self.find_or_create(args)
    Activity.find_by(args) || Activity.create!(ensure_hidden_is_set(args))
  end

  def zone
    category if category.zone?
  end

  def hide
    self.hidden = true
    save
  end

  def unhide
    self.hidden = false
    save
  end

  def self.ensure_hidden_is_set(args)
    args[:hidden] = false unless args.key?(:hidden) && !args[:hidden].empty?
    args
  end
  private_class_method :ensure_hidden_is_set
end
