class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def update
    @user = User.find(params[:user][:id])

    if @user.update_attributes(user_params)
      flash.delete(:alert)
      redirect_to @user, notice: changed_attributes_message
    else
      flash[:alert] = @user.errors.messages.values.join(', ')
      render 'show'
    end
  end

  private

  def changed_attributes_message
    changed_fields = @user.previous_changes.keys
    changed_fields.delete('updated_at')
    changed_fields.map! { |field| field.gsub('_', ' ') }
    return nil unless changed_fields.any?
    "Updated #{changed_fields.join(', ')}"
  end

  def user_params
    params.require(:user).permit(:id, :email, :zipcode, :political_party)
  end
end
