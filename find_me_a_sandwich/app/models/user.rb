class User < ActiveRecord::Base
  VALID_NAME_PATTERN = /\A[A-Za-z\-' ]*\z/

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  belongs_to :location

  validates_format_of :last_name, :first_name, with: VALID_NAME_PATTERN

  scope :visible, -> { where(profile_visible: true) }
  scope :order_by_name, -> { order(:last_name, :first_name) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
