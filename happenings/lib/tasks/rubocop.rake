# rubocop is not available in non-dev environments (and shouldn't be)
begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
end
