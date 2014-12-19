namespace :event do

  desc 'Creates events for the current year'
  task theatre: :environment do
    initial_count = Event.count
    events = TheatreInChicagoEvents.get_events_for_year
    events.each { |event| CreateEvent.create(event) }
    puts "Created #{Event.count - initial_count} events"
  end

  desc 'Delete all events'
  task clear: :environment do
    Event.all.each(&:destroy!)
  end
end
