class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, 
    presence: true,
    length: { minimum: 5 },
    uniqueness: true,
    format: { with: /[a-zA-Z]+/, message: 'must contain at least 1 letter' }

  validates :password,
            presence: true,
            length: { minimum: 8 },
            confirmation: true,
            format: { with: /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/,
                      message: 'must contain at least 1 lowercase, 1 uppercase 
                               and 1 number' }
end