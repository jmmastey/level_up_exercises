CUKE_OPTS = {
  all_on_start: true,
  cli: "--color --strict",
  bundler: true,
  feature_sets: ['test/features'],
  notification: true
}

RSPEC_OPTS = {  
  all_on_start: true,
  cmd: "bundle exec rspec --tty --color",
  spec_paths: ['test/spec'],
  notification: true
}

RUBOCOP_OPTS = {
  all_on_start: false,
  cli: [],
  notification: true
}

guard :shell, notification: true do
  watch(%r{^Rakefile|(?:(?:test|lib)/(?:support|utility)/|main)(.+)\.rb}) do |m|
    ::Guard.evaluator.reevaluate_guardfile
  end
end

group :red_green_refactor, halt_on_fail: true do
  guard :cucumber, CUKE_OPTS do
    watch(%r{^test/features/.+\.feature$})
    watch(%r{^test/features/(?:support|step_definitions)/(.+)(?:_steps)\.rb$}) do |m|
      Dir[File.join("**/#{m[1]}.feature")][0] || CUKE_OPTS[:feature_sets]
    end
  end

  guard :rspec, RSPEC_OPTS do
    watch(%r{^test/support/spec_helper\.rb}) { "test/spec" }
    watch(%r{^test/spec/(.+)\.rb})           { |m| "#{m[0]}" }
    watch(%r{^lib/(.+)\.rb})                 { |m| "test/spec/lib/#{m[1]}_spec.rb" }
  end

  guard :rubocop, RUBOCOP_OPTS do
    watch(%r{lib/(.+)\.rb$}) { |m| "#{m[0]}" }
  end
end

