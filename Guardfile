require 'pathname'
require "#{File.dirname(__FILE__)}/spec/system_helper.rb"

RUBOCOP_OPTS = {
  all_on_start: true,
  cli: ['--format', 'clang', '--rails']
}

RSPEC_OPTS = {
  cmd: 'bundle exec rspec --tty --color',
  notification: true,
  all_on_start: true
}

group :red_green_refactor, halt_on_fail: true do
  guard :rspec, RSPEC_OPTS do
    watch(%r{^lib/(.+)\.rb})      { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^spec/(.+)\.rb})     { |m| "#{m[0]}" }
  end

  guard :rubocop, RUBOCOP_OPTS do
    watch(%r{^(.+)\.rb})
  end
end
