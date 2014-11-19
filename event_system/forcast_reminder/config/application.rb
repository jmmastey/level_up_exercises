require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ForcastReminder
  class Application < Rails::Application
    # Set Time.zone default to the specified zone and make
    # Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    # Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'
    config.active_record.raise_in_transactional_callbacks = true
  end
end
