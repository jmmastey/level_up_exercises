class TermsController < ApplicationController
  before_action :logged_in_user

  def new
    @term = Term.new
  end

  def create
    @term = Term.new(term_params)
    @term.user_id = current_user.id
    @term.options = options(params)
    if @term.save
      flash[:success] = 'Term successfully created.'
    else
      flash[:danger] = 'Could not create term.'
    end
    redirect_to :back
  end

  def update
    @term = Term.find(params[:id])
    if @term.update(options: params[:options])
      flash[:success] = 'Successfully updated term.'
    else
      flash[:danger] = 'Could not update term.'
    end
    redirect_to '/terms'
  end

  def destroy
    Term.find(params[:id]).destroy
    flash[:success] = 'Successfully deleted term.'
    redirect_to '/terms'
  end

  def index
    @terms = Term.where(user_id: current_user.id).order(year: :ASC, month: :ASC)
    @categories = Category.where(user_id: current_user.id).order(name: :ASC)
  end

  def show
    @term = Term.find(params[:id])
  end

  def current
    @term = Term.find_by(user_id: current_user.id,
                         month: Time.now.month, year: Time.now.year)
  end

  def next
    @term = Term.find_by(user_id: current_user.id,
                         month: (Time.now + 1.month).month,
                         year: (Time.now + 1.month).year)
  end

  def add_money_to_category
    Fund.where(user_id: current_user.id).each do |fund|
      unless params[fund.name].nil? || params[fund.name].empty?
        amount = params[fund.name].to_d
        update_term(params[:term_id], fund.id, params[:name], amount)
        update_fund(fund, params[:term_id], amount)
      end
    end

    redirect_to :back
  end

  def restore_money
    term = Term.find(params[:id])
    amount = term.remaining_money(params[:name])
    restore_from_term(term, params[:name], amount)
    restore_to_fund(term.options[params[:name]][:budgeted_amount].first[0],
                    term.date, amount)
    flash[:success] = 'Money successfully transferred.'
    redirect_to :back
  end

  private

  def restore_from_term(term, name, amount)
    term.options[name][:amount_spent] = amount
    term.save
  end

  def restore_to_fund(id, date, amount)
    fund = Fund.find(id)
    if fund.components['Reserved'][date] - amount == 0
      fund.components['Reserved'].delete(date)
    else
      fund.components['Reserved'][date] -= amount
    end
    fund.components['Available'] += amount
    fund.save
  end

  def update_fund(fund, term_id, amount)
    term = Term.find(term_id)
    fund.components['Available'] -= amount
    fund.components['Reserved'][term.date] ||= 0.0
    fund.components['Reserved'][term.date] += amount
    fund.save
  end

  def update_term(term_id, fund_id, name, amount)
    term = Term.find(term_id)
    term.options[name][:budgeted_amount][fund_id] ||= 0.0
    term.options[name][:budgeted_amount][fund_id] += amount
    term.save
  end

  def term_params
    params.require(:term).permit(:month, :year, :user_id, :options)
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = 'Please log in first.'
    redirect_to root_path
  end

  def options(params)
    options = {}
    categories = Category.where(user_id: current_user.id).order(name: :ASC)
    categories.each do |category|
      if params["#{category.name}-check"]
        options[category.name] = { budgeted_amount: {}, amount_spent: 0.0 }
      end
    end
    options
  end
end
