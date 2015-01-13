require 'open-uri'
require 'JSON'
class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    # pull_events if Event.all.count == 0
    @last_updated = Event.all.order('updated_at').last.updated_at.strftime("%d-%m-%Y")
    # pull_events if @last_update != Time.now.strftime("%d-%m-%Y")
    if Event.all.count == 0
      pull_events
    elsif @last_updated != Time.now.strftime("%d-%m-%Y")
      pull_events
    end

    @events =  Event.where(date: (Time.now.midnight-1.day)..Time.now.midnight).order('avg_price DESC')
    @carousel = Event.where(date: (Time.now.midnight-1.day)..Time.now.midnight+6.day).order('avg_price DESC').take(5)
    @week = Event.where(date: (Time.now.midnight+1.day)..Time.now.midnight+6.day).order('date')
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @venue = Venue.find(@event.venue_id)
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:avg_price, :low_price, :high_price, :title)
    end

    def pull_events
      date = DateTime.now.strftime('%F')
      tomorrow = DateTime.now.next_week.strftime('%F')
      test = open("http://api.seatgeek.com/2/events?geoip=true&per_page=50&range=20mi&datetime_local.gte=#{date}&datetime_local.lt=#{tomorrow}")
      file = File.read(test)
      data_hash = JSON.parse(file)

      data_hash['events'].each do |event|
        venue = Venue.where(id: "#{event['venue']['id']}")
        unless venue.count > 0
          venue = Venue.new
          venue.id = event['venue']['id']
          venue.name = event['venue']['name']
          venue.address = event['venue']['address']
          venue.longitude = event['venue']['location']['lon']
          venue.latitude = event['venue']['location']['lat']
          venue.save
        end
        venue = Venue.find(event['venue']['id'])
        new_event = Event.new
        new_event.id = event['id']
        new_event.title = event['title']
        new_event.venue_id = venue.id
        new_event.listings = event['stats']['listing_count']
        new_event.link = event['url']
        new_event.picture = event['performers'][0]['image'] if event['performers'][0]['image'] != nil
        new_event.avg_price = event['stats']['average_price'].to_f
        new_event.low_price = event['stats']['lowest_price'].to_f
        new_event.date = event['datetime_utc']
        new_event.save
      end
    end

    def date_check
      if Event.all.count == 0
        return false
      end
      @last_updated = Event.all.order('updated_at').last.updated_at.strftime("%d-%m-%Y")
      @last_update == Time.now.strftime("%d-%m-%Y")
    end

end
