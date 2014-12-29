class SelectionCriteriaController < ApplicationController
  before_action :set_selection_criterion, only: [:show, :edit, :update, :destroy]
  before_action :set_feed, only: [:new]

  respond_to :html

  PERMITTED_PARAMS = [:implementation_class, :configuration, :sql_expression]

  def index
    @selection_criteria = SelectionCriterion.all
    respond_with(@selection_criteria)
  end

  def show
    respond_with(@selection_criterion)
  end

  def new
    @selection_criterion = SelectionCriterion.new
    respond_with(@selection_criterion)
  end

  def edit
  end

  def create
    @selection_criterion = SelectionCriterion.new(selection_criterion_params)
    @selection_criterion.save
    respond_with(@selection_criterion)
  end

  def update
    @selection_criterion.update(selection_criterion_params)
    respond_with(@selection_criterion)
  end

  def destroy
    @selection_criterion.destroy
    respond_with(@selection_criterion)
  end

  private

  def set_selection_criterion
    @selection_criterion = SelectionCriterion.find(params[:id])
  end

  def set_feed
    @feed = Feed.find_by(id: params[:feed_id], user: current_user)
    raise "Invalid Feed" unless @feed
  end

  def selection_criterion_params
    params.require(:selection_criterion).permit(PERMITTED_PARAMS)
  end
end
