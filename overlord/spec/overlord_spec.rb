require 'spec_helper'

describe Overlord::Bomber do

  def app
    @app ||= Overlord::Bomber
  end

  describe "GET '/'" do
    it "should be successful" do
      get '/'
      expect(last_response).to be_ok
    end
  end
end
