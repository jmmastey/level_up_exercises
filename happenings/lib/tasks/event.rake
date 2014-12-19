namespace :event do

  desc 'Creates events for the current year'
  task theatre: :environment do
    counts = { init:      Event.count,
               total:     0,
               invalid:   0,
               exists:    0 }
    events = TheatreInChicagoEvents.get_events_for_year
    events.each do |event|
      result = CreateEvent.create(event)
      update_count(result, counts)
    end
    print_final_count(counts)
  end

  desc 'Delete all events'
  task clear: :environment do
    Event.all.each(&:destroy!)
  end

  def update_count(result, counts)
    counts[:total] += 1
    case result
    when nil
      counts[:exists] += 1
    when result.try(:errors).present?
      counts[:invalid] += 1
    end
  end

  def print_final_count(counts)
    puts "Total Events received: #{counts[:total]}"
    puts "Total Events created:  #{Event.count - counts[:init]}"
    puts "Invalid events:        #{counts[:invalid]}"
    puts "Existing(dup) events:  #{counts[:exists]}"
  end
end
