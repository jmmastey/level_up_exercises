class CalendarController < ApplicationController
  before_filter :prepare_session
	def prepare_session
	  ScraperWorker.perform_async
	end
  
	def show
	  @date = params[:date] ? Date.parse(params[:date]) : Date.today
	  @events_by_date = Event.select("id, title, location, date, time")
	end
end
