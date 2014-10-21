require 'rubygems'
<<<<<<< HEAD
require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'
=======

require 'rspec/core/rake_task'
>>>>>>> 0a509545fa0c4bf48fe0cbfe113c94af6fbb562f

require_relative 'spec/system_helper.rb'

RSpec::Core::RakeTask.new(:spec)

<<<<<<< HEAD
task :default do
  :guard
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty"
end
=======
task default: :guard
>>>>>>> 0a509545fa0c4bf48fe0cbfe113c94af6fbb562f

task :guard do
  run_command('bundle exec guard --no-interactions --clear')
end

task :specs do
  Rake::Task[:rspec].invoke('spec')
end

task :rspec do |_, args|
  run_command("bundle exec rspec --tty --color #{args.join(' ')}")
end
<<<<<<< HEAD

task web: do
  bundle exec rackup config.ru -p $PORT
end

=======
>>>>>>> 0a509545fa0c4bf48fe0cbfe113c94af6fbb562f
