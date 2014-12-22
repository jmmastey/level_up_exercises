class EventSearch
  attr_accessor :errors, :events

  def initialize(params)
    @params = params
  end

  def self.call(params)
    event_scope = Event.order('created_at DESC')
    event_scope = event_scope.with_source(params[:event_source] || :theatre_in_chicago)
    event_scope = event_scope.where('date >= ?', params[:start_date]) if params[:start_date].present?
    event_scope = event_scope.where('date <= ?', params[:end_date]) if params[:end_date].present?
    event_scope = event_scope.where("description like '%#{params[:description]}%'") if params[:description].present?
    event_scope
  end
end
