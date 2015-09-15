class QuestsController < ApplicationController
  before_action :set_quest, only: [:show, :edit]

  def edit
    redirect_to(quest_path)
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end
end
