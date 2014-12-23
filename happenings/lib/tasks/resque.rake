require 'resque/tasks'
require 'resque/scheduler/tasks'

namespace :resque do
  task :setup => :environment do
    require 'resque'
    require 'resque-scheduler'

    Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
    Resque.schedule = YAML.load_file("#{Rails.root}/config/schedule.yml")
  end
end

