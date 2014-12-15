class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :feeds, dependent: :delete_all, foreign_key: :owner_user_id

  def full_name
    [first_name, last_name].compact.join(" ")
  end
end
