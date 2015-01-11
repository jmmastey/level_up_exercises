class EventsController < ApplicationController
  helper :all
  before_action :init_session, only: :index
  before_action :verify_filter_params, only: :filter
  before_action :verify_page_param, only: :page

  def index
    @data = Event.all(session[:params][:start_date])
    return render_500 if @data == false
    update_session
  end

  def page
    @data = Event.filter(session[:params])
    return render_500 if @data == false
    custom_render
  end

  def filter
    @data = Event.filter(session[:params])
    return render_500 if @data == false
    update_session
    custom_render
  end

  private

  def init_session
    session[:params] = {}
    session[:params][:query] = 'running'
    session[:params][:start_date] = "#{Time.now.strftime('%F')}.."
    session[:params][:current_page] = 1
  end

  def update_session
    total_pages = @data['total_results'] / 10
    total_pages += 1 if  (@data['total_results'] % 10) > 0
    session[:total_page] = total_pages
  end

  def verify_filter_params
    date = "#{params['start_date']}..#{params['end_date']}"
    session[:params]['start_date'] = date if date.length > 2
    run_type = params['running_type']
    session[:params]['query'] = run_type
    session[:params][:current_page] = 1
  end

  def verify_page_param
    page_num = params[:page_num].to_i
    render 404 if page_num > session[:total_page]
    session[:params]['current_page'] = params[:page_num].to_i
  end

  def render_500
    file_path = "#{Rails.root}/public/500.html"
    respond_to do |format|
      format.html { render file: file_path, status: 500, layout: false }
    end
  end

  def custom_render
    file_path = "#{Rails.root}/public/403.html"
    respond_to do |format|
      format.html { render file: file_path, status: 403, layout: false }
      format.js
    end
  end
end
