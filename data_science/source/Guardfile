require 'pathname'
require "#{File.dirname(__FILE__)}/spec/system_helper.rb"

SHELL_OPTS = {
  notification: true,
  all_on_start: true
}
guard :shell, SHELL_OPTS do
  watch(%r{^(.+)\.rb}) do |m|
    file = Pathname.new(m[0]).basename
    puts "Rubocop: #{m[0]}"
    output = run_command("bundle exec rubocop #{m[0]}")
    result = output.match(/^(\d file inspected.*)$/)
    n result.to_s, "Rubocop: #{file}"
  end
end

RSPEC_OPTS = {
  cmd: 'bundle exec rspec --tty --color',
  notification: true,
  all_on_start: true
}
guard :rspec, RSPEC_OPTS do
  watch(%r{^lib/(.+)\.rb})      { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/(.+)\.rb})     { |m| "#{m[0]}" }
end