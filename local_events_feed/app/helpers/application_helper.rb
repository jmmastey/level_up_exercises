module ApplicationHelper
  def render_calendar_publish(showing)
    calendar = Icalendar::Calendar.new
    calendar.add_event(showing.ics)
    calendar.publish
    calendar.to_ical
  end

  LOCAL_TIME_ZONE = "Central Time (US & Canada)"

  class LocalTimeView
    def initialize(time)
      @time = to_local_tz(time)
    end
    
    def to_s
      @time.strftime('%m/%d/%Y %I:%M %P')
    end

    def pretty_date
      @time.strftime('%a, %b %-d, %Y')
    end

    def pretty_date_no_dow
      @time.strftime('%b %-d, %Y')
    end

    def pretty_date_no_year
      @time.strftime("%b %-d")
    end
      
    def pretty_dow
      @time.strftime('%a')
    end
    
    def pretty_time
      @time.strftime('%I:%M %P')
    end

    private
    
    def to_local_tz(time)
      time.in_time_zone(LOCAL_TIME_ZONE)
    end
  end
end
