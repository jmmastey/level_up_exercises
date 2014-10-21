require_relative '../spec/helpers/spec_helper'

describe 'Overlord' do
  describe "Controller" do
    it "loads first page" do
      get '/'
      expect(last_response).to be_ok
    end
  end

  describe "Activation" do
    before :each do
      configure_bomb
    end

    it "should be able to be configured" do
      expect(last_response.body).to include("activation code")
      expect(session[:bomb_status]).to equal(:configured)
    end

    it "should be able to be activated" do
      activate_bomb
      expect(session[:bomb_status]).to equal(:activated)
    end

    it "should not activate with deactivation code" do
      activate_bomb(1234)
      expect(session[:bomb_status]).to equal(:configured)
    end

    it "shoudld explode after 3 wrong activation attempts" do
      3.times do
        activate_bomb(1234)
      end
      expect(session[:bomb_status]).to equal(:exploded)
    end

    it "should not allow me to activate an already activated bomb" do
      activate_bomb
      get '/'
      expect(session[:bomb_status]).to equal(:activated)
    end

    it "should not have a valid bomb status if not configured" do
      get '/'
      expect(session[:bomb_status]).to be nil
    end
  end

  describe "Deactivation" do
    before :each do
      configure_bomb
    end

    it "should be able to be deactivated" do
      activate_bomb
      deactivate_bomb
      expect(session[:bomb_status]).to equal(:deactivated)
    end

    it "should not deactivate with activation code" do
      activate_bomb
      deactivate_bomb(1111)
      expect(session[:bomb_status]).to equal(:activated)
    end

    it "should explode after 3 bad deactivation attempts" do
      3.times do
        deactivate_bomb(7777)
      end
      expect(session[:bomb_status]).to equal(:exploded)
    end

    it "should allow me to snip the wire for an activated bomb" do
      activate_bomb
      expect(session[:bomb_status]).to equal(:activated)
      post '/snippy'
      expect(session[:bomb_status]).to equal(:deactivated)
    end
  end
end
