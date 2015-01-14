FactoryGirl.define do
  factory :calendar_event, class: CalendarEvent do
    title "History of Armpit Hair Folk Art"
    event_source
    start_time DateTime.new(2015, 1, 23, 11, 30, 0, -6)
    end_time DateTime.new(2015, 1, 23, 11, 31, 0, -6)
    description <<-EOF
      A term coined specifically for an RSpec example, the decorated history
      of armpit hair as artistic medium stretches all the way back to ten
      minutes ago before my boxed au gratin potatoes had even been mixed.
      EOF
  end
end
    
