class UserController < ApplicationController
  before_action :authenticate_user!

  def favorite
    favorite_or_unfavorite_model('favorite')
    redirect_to_back_or_default
  end

  def unfavorite
    favorite_or_unfavorite_model('unfavorite')
    redirect_to_back_or_default
  end

  private

  def id
    params[:id]
  end

  def favorite_or_unfavorite_model(action)
    return unless params[:model].in? %w(bill legislator)
    method = method_name(action, params[:model])
    send(method)
  end

  def method_name(action, model)
    [action, model].join('_').to_sym
  end

  def favorite_bill
    f_bill = current_user.favorite_bills.find_or_create_by(bill_id: id)
    flash[:notice] = "Favorited #{f_bill.bill.title_with_id.truncate(100)}"
  end

  def favorite_legislator
    f_legislator = current_user.favorite_legislators.find_or_create_by(legislator_id: id)
    flash[:notice] = "Favorited #{f_legislator.legislator.name_with_title}"
  end

  def unfavorite_bill
    f_bill = current_user.favorite_bills.find_by(bill_id: id)
    return if f_bill.nil?
    flash[:notice] = "Unfavorited #{f_bill.bill.title_with_id.truncate(100)}"
    f_bill.delete

  end

  def unfavorite_legislator
    f_legislator = current_user.favorite_legislators.find_by(legislator_id: id).try(:delete)
    return if f_legislator.nil?
    flash[:notice] = "Unfavorited #{f_legislator.legislator.name_with_title}"
    f_legislator.delete
  end
end
