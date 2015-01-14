# encoding: utf-8

require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"

  exit e.status_code
end


# default task ------------------------

task :default => :spec


# rspec -------------------------------

require 'rake'

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end


# cucumber ----------------------------

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features)
