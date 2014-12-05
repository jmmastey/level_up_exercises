require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Openmooc
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')

    config.action_view.field_error_proc = proc do |html_tag, _instance|
      if html_tag =~ /<(input|textarea|select)/
        html_field = Nokogiri::HTML::DocumentFragment.parse(html_tag)
        html_field.children.add_class 'input-error'
        html_field.to_s.html_safe
      else
        html_tag
      end
    end
  end
end
