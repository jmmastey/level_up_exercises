require 'dm-types'
require 'dm-validations'

class Wire < ActiveRecord::Base
  belongs_to :bomb
end
