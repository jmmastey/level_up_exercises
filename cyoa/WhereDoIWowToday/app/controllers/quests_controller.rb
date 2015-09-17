class QuestsController < ApplicationController
  before_action :set_quest, only: [:show, :edit, :update]

  def edit
    redirect_to(quest_path) unless admin_user?
  end

  def update
    redirect_to(quest_path) and return unless admin_user?
    category_name = params[:category]
    redirect_to(quest_path) and return unless useful_value?(category_name)
    @quest.categories << Category.find_by(name: category_name)
    redirect_to(quest_path)
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def admin_user?
    user_signed_in? && current_user.admin?
  end

  def useful_value?(name)
    !name.nil? && !name.empty?
  end
end
