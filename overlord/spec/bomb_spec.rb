require 'spec_helper'
require './bomb.rb'

describe Bomb do
  DEFAULT_STATE = "Inactive"
  DEFAULT_ACTIATION_CODE = 1234
  DEFAULT_DEACTIVATION_CODE = '0000'

  subject(:bomb) { Bomb.new(activation_code = 3565, deactivation_code = "face") }


end
