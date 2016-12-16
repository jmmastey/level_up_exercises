class LegislatorsController < ApplicationController
  before_action :ensure_nonempty_query, only: :index

  def index
    query = LegislatorQuery.new(Legislator.all, @search_params)
    @legislators = query.execute.order(:first_name)
    @num_legislators = @legislators.count
    @legislators = @legislators.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render 'index', layout: false }
    end
  end

  def show
    @legislator = Legislator.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render 'show', layout: false }
    end
  end

  private

  def ensure_nonempty_query
    @search_params = legislator_params[:query].to_s.strip
    render(layout: false) && return if @search_params.empty?
  end

  def legislator_params
    params.require(:legislator).permit(:query)
  end
end
