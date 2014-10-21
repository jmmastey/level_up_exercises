require 'rails_helper'

RSpec.describe Performance, :type => :model do
  it { should validate_presence_of :performed_on }
  it { should validate_presence_of :show }
end
