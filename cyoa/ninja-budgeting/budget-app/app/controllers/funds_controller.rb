class FundsController < ApplicationController
  before_action :logged_in_user

  def new
    @fund = Fund.new
  end

  def create
    @fund = Fund.new(fund_params)
    @fund.user_id = current_user.id
    @fund.components = { 'Available' => @fund.amount,
                         'Reserved' => {}, 'Pending' => {} }

    if @fund.save
      flash[:success] = 'Fund successfully added.'
    else
      flash[:danger] = 'Could not add fund.'
    end
    redirect_to :back
  end

  def update
    @fund = Fund.find(params[:id])
    if @fund.update(name: params[:name], amount: params[:amount])
      flash[:success] = 'Fund successfully updated.'
    end
    redirect_to '/funds'
  end

  def destroy
    Fund.destroy(params[:id])
    flash[:success] = 'Fund deleted.'
    redirect_to '/funds'
  end

  def add_to_reserve
    @fund = Fund.find(params[:fund_id])
    amount = params[:amount].to_d

    # Amount > available
    if params[:amount].to_d > @fund.components['Available']
      flash[:danger] = 'You cannot reserve more money than what is available.'
    else
      @fund.components = update_fund_reserve(@fund, amount, params[:name])
      @fund.save
    end

    redirect_to '/funds'
  end

  def index
    @funds = Fund.where(user_id: current_user.id).order(name: :ASC)
    @inputs = []
    @funds.each do |fund|
      @inputs << Transaction.where(transaction_type: 'input', fund_id: fund.id)
    end
    @inputs.flatten!
    @inputs.sort! { |first, second| first.created_at <=> second.created_at }
    @inputs.reverse!
  end

  def add
    @fund = Fund.find(params[:id])
    @fund.amount += params[:amount].to_d
    @fund.components['Available'] += params[:amount].to_d
    @fund.save
    create_transaction(params, @fund.id)
    flash[:success] = 'Successfully added money to fund.'
    redirect_to :back
  end

  private

  def create_transaction(params, fund_id)
    term_id = params[:term_id].nil? ? 0 : params[:term_id]
    date = "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}"
    Transaction.create(amount: params[:amount], date: date,
                       description: params[:description], term_id: term_id,
                       transaction_type: 'input', fund_id: fund_id)
  end

  def update_fund_reserve(fund, amount, name)
    fund.components['Savings'][name] = amount
    fund.components['Available'] -= amount
    fund.components
  end

  def fund_params
    params.require(:fund).permit(:name, :amount, :fund_type, :components)
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = 'Please log in first.'
    redirect_to root_path
  end
end
