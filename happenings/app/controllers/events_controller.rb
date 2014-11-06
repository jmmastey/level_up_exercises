require 'icalendar'
class EventsController < ApplicationController	
  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html
      format.ics do
        calendar = Icalendar::Calendar.new
        calendar.add_event(@event.to_ics)
        calendar.publish
        render :text => calendar.to_ical
      end
    end
  end
end
