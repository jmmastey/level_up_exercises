require 'rspec/expectations'

RSpec.describe Capybara do
  describe 'default_max_wait_time' do
    after do
      Capybara.default_max_wait_time = 4
    end
  end
end
