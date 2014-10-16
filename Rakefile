require 'rubygems'
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

require_relative 'spec/system_helper.rb'

RSpec::Core::RakeTask.new(:spec)

task :default do
  :guard
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end

task :guard do
  run_command('bundle exec guard --no-interactions --clear')
end

task :specs do
  Rake::Task[:rspec].invoke('spec')
end

task :rspec do |_, args|
  run_command("bundle exec rspec --tty --color #{args.join(' ')}")
end

task web: do
  bundle exec rackup config.ru -p $PORT
end

