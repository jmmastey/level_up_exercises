require 'spec_helper'
# require 'capybara'
# require 'capybara/dsl'

RSpec.configure do |config|
  config.include Capybara::DSL

end

describe Overlord::Bomber do

  Capybara.default_driver = :selenium

  # https://gist.github.com/zhengjia/428105
  # (Slide 44) http://www.slideshare.net/bsbodden/rspec-and-capybara
  # http://youtu.be/BG_DDUD4M9E?t=47m18s
  # https://learn.thoughtbot.com/test-driven-rails-resources/capybara.pdf

  def app
    Capybara.app = Overlord::Bomber
  end

  describe "GET '/'" do
    it "should be successful" do
      get '/'
      expect(last_response).to be_ok
    end
  end

  describe "the home state" do
    it "should have the machine title" do
      visit '/'
      expect(page.has_content?("ENNIHILATION")).to be_truthy
    end
  end


end
