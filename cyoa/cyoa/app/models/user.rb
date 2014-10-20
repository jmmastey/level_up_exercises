class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
       # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :artists

end
