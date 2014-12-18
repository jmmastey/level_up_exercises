class SelectionCriteriaController < ApplicationController
  before_action :set_selection_criterium, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @selection_criteria = SelectionCriterium.all
    respond_with(@selection_criteria)
  end

  def show
    respond_with(@selection_criterium)
  end

  def new
    @selection_criterium = SelectionCriterium.new
    respond_with(@selection_criterium)
  end

  def edit
  end

  def create
    @selection_criterium = SelectionCriterium.new(selection_criterium_params)
    @selection_criterium.save
    respond_with(@selection_criterium)
  end

  def update
    @selection_criterium.update(selection_criterium_params)
    respond_with(@selection_criterium)
  end

  def destroy
    @selection_criterium.destroy
    respond_with(@selection_criterium)
  end

  private
    def set_selection_criterium
      @selection_criterium = SelectionCriterium.find(params[:id])
    end

    def selection_criterium_params
      params.require(:selection_criterium).permit(:implementation_class, :configuration, :sql_expression)
    end
end
