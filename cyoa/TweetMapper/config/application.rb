require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module TweetMapper
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.assets.paths << Rails.root.join('vendor', 'assets')

    config.autoload_paths << Rails.root.join('lib')

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.maximum_markers = 100
    config.seconds_between_screen_refreshes = 5
    config.seconds_api_buffer = 1
    config.tweets_to_take = 100
  end
end
