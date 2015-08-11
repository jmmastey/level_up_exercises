class UserTagsController < ApplicationController
  before_action :authenticate_user!

  def create
    user_tag = UserTag.new(user_tag_params)

    if user_tag.save
      redirect_to user_tag.user, notice: 'Updated tags'
    else
      flash[:alert] = user_tag.errors.messages.values.join(', ')
      render 'users/show'
    end
  end

  def destroy
    @tag_id = params[:tag_id]
    UserTag.where(user_id: current_user.id, tag_id: @tag_id).first.destroy
    render layout: false
  end

  private

  def user_tag_params
    params.require(:user_tag).permit(:tag_id, :user_id)
  end
end
