require 'rails_helper'

RSpec.describe Artwork, :type => :model do
  # Validations
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:date) }

  # Associations
  it { should belong_to(:artist) }
end
