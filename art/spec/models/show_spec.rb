require 'rails_helper'

RSpec.describe Show, :type => :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :year }
  it { should validate_presence_of :location }
  it { should validate_presence_of :director }
  it { should validate_presence_of :theatre_company }
  it { should validate_presence_of :notes }
  it { should have_many :performances }
end
