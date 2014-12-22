class EventSearch
  attr_accessor :errors, :events

  def initialize(params)
    @params = params
  end

  def self.call(params)
    event_scope = Event.order('created_at DESC')
    event_scope = event_scope.with_source(params[:event_source] || :theatre_in_chicago)
    event_scope = event_scope.where('date >= ?', start_date) if params[:start_date]
    event_scope = event_scope.where('date <= ?', end_date) if params[:end_date]
    event_scope
  end
end
