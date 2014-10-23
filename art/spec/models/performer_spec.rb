require 'rails_helper'

RSpec.describe Performer, :type => :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should have_many :shows }
  it { should have_many :performances }
end
