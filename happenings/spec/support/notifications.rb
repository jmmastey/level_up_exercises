# File notifications.rb
ActiveSupport::Notifications.subscribe("factory_girl.run_factory") do |payload|
  execution_time_in_seconds = finish - start

  if execution_time_in_seconds >= 0.5
    $stderr.puts "Slow factory: #{payload[:name]} using strategy
#{payload[:strategy]}"
  end
end
