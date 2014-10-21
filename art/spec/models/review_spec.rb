require 'rails_helper'

RSpec.describe Review, :type => :model do
  it { should validate_presence_of :user }
  it { should validate_presence_of :performance }
  it { should validate_presence_of :rating }
  it { should validate_numericality_of :rating }
  it { should_not validate_presence_of :review }
end
