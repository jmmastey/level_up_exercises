class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :favorite_legislators
  has_many :legislators, through: :favorite_legislators
  has_many :favorite_bills
  has_many :bills, through: :favorite_bills
end
