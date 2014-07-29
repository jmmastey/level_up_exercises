require 'capybara/rspec'
require 'spec_helper'

RSpec.configure do |config|
  config.include Capybara::DSL
end

feature Overlord::Bomber, :type => :feature do

  Capybara.default_driver = :selenium

  def app
    Capybara.app = Overlord::Bomber
  end

  describe "GET '/'" do
    it "should be successful" do
      get '/'
      expect(last_response).to be_ok
    end
  end

  describe "start boot process with valid and invalid content" do
    it "should show a boot page" do
      visit '/boot_process'

      expect(page).to have_button('Boot Up')

      fill_in('post[activation-code]', :with => "12344")
      expect(page).to have_content("Activation code must be 4 numbers")

      fill_in('post[activation-code]', :with => "1111")
      expect(page).to_not have_content("Activation code must be 4 numbers")

      fill_in('post[activation-code]', :with => "abcd")
      expect(page).to have_content("Activation code must be 4 numbers")

      fill_in('post[activation-code]', :with => "4444")
      expect(page).to_not have_content("Activation code must be 4 numbers")

      fill_in('post[deactivation-code]', :with => "12344")
      expect(page).to have_content("Deactivation code must be 4 numbers")

      fill_in('post[deactivation-code]', :with => "1111")
      expect(page).to_not have_content("Deactivation code must be 4 numbers")

    end
  end

  describe "cancel boot process" do
    it "should go back to home (off)" do
      visit '/boot_process'
      click_button('Cancel')
      expect(page.has_content?("ENNIHILATION")).to be_truthy
    end
  end


  describe "activating the bomb" do
    it "should show ticker" do

      visit '/boot_process'
      fill_in('post[activation-code]', :with => "1234")
      fill_in('post[deactivation-code]', :with => "1234")
      click_button('Boot Up')

      click_button('Activate')

      fill_in('post[seconds-to-boom]', :with => "30")
      fill_in('post[activation-code]', :with => "1234")

      click_button('Boot')

      expect(page).to have_content("DANGER!")


    end
  end


  describe "deactivating the bomb" do
    it "should turn off the bomb" do

      visit '/boot_process'
      fill_in('post[activation-code]', :with => "1234")
      fill_in('post[deactivation-code]', :with => "1234")
      click_button('Boot Up')

      click_button('Activate')

      fill_in('post[seconds-to-boom]', :with => "30")
      fill_in('post[activation-code]', :with => "1234")

      click_button('Boot')

      click_button('Deactivate')

      fill_in('post[deactivation-code]', :with => "1234")

      click_button('Deactivate')

      expect(page).to have_content("OFF")


    end
  end


end
