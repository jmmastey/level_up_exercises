require 'yaml'

require 'resque'
require 'resque_scheduler'

rails_root = defined?(Rails) ? Rails.root.to_s : ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env  = defined?(Rails) ? Rails.env.to_s  : ENV['RAILS_ENV']  || 'development'

resque_config = YAML.load_file(rails_root + '/config/resque.yml')
Resque.redis = resque_config[rails_env]

Resque.redis.namespace = "resque:happenings"

Resque.schedule = YAML.load_file(rails_root + '/config/schedule.yml')

Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
