require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ArtistsHelper. For example:
#
# describe ArtistsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, :type => :helper do

  describe "#account_type" do

      it "displays Administrator if user is an admin" do
        @user =  create(:user, admin: true)

        expect(helper.account_type).to eq("Administrator")
      end


      it "displays Basic if user is not an admin" do
        @user =  create(:user)

        expect(helper.account_type).to eq("Basic")
      end
  end
end
