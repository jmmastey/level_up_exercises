require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Eve
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.sass.preferred_syntax = :sass
    config.action_controller.action_on_unpermitted_parameters = :log
  end
end
