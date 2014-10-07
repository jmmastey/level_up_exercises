load 'main.rb'
require 'test/support/stdout_helper'

require 'rubygems'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec)

task default: :guard

task :guard do
  run_command('bundle exec guard --no-interactions')
end

task :specs do
  Rake::Task[:rspec].invoke('spec')
end

task :rspec do |_, args|
  run_command("bundle exec rspec --tty --color #{args.join(' ')}")
end

