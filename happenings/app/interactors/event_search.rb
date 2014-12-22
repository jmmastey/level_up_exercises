class EventSearch
  attr_accessor :errors, :events

  def initialize(params)
    @params = params
  end

  def self.search(params)
    event_scope = Event.order('created_at DESC')
    event_scope = event_scope.where(event_source: source) if params[:event_source]
    event_scope = event_scope.where('date >= ?', start_date) if params[:start_date]
    event_scope = event_scope.where('date <= ?', end_date) if params[:end_date]
  end
end
