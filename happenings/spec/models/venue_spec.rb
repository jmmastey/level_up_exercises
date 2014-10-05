require 'rails_helper'

RSpec.describe Venue, type: :model do

  context 'model responds to' do
    vars = FactoryGirl.attributes_for(:venue).keys
    vars.each do |key|
      it key do
        expect(subject).to respond_to(key)
      end

    end
  end
end
