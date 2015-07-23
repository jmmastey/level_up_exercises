# bundle exec rackup config.ru

require './overlord'

require 'sass'
require 'sass/plugin/rack'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run Project::Overlord
