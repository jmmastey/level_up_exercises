require 'dm-types'
require 'dm-validations'

class Wire < ActiveRecord::Base
  belongs_to :bomb
  validates_presence_of :color, :diffuse
end