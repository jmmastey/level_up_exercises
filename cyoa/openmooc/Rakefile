require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :cop do
  system('rubocop -c .hound.yml app lib')
end
