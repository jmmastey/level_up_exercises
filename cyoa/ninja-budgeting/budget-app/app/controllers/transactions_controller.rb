class TransactionsController < ApplicationController
  before_action :logged_in_user

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      update_fund(@transaction)
      update_term(@transaction)
      flash[:success] = 'Successfully created transaction.'
    else
      flash[:danger] = 'Could not add transaction.'
    end
    redirect_to :back
  end

  def paid
    transaction = Transaction.find(params[:id])
    term = Term.find(transaction.term_id)

    update_fund_paid(transaction.fund_id, transaction.amount, term.date)

    transaction.update(paid: true)
    redirect_to :back
  end

  private

  def update_fund_paid(fund_id, amount, date)
    fund = Fund.find(fund_id)
    fund.amount -= amount
    fund.components['Pending'][date] -= amount
    if fund.components['Pending'][date] == 0
      fund.components['Pending'].delete(date)
    end
    fund.save
  end

  def update_fund(transaction)
    fund = Fund.find(transaction.fund_id)
    term = Term.find(transaction.term_id)
    if fund.fund_type == 'credit'
      fund.amount += transaction.amount
    elsif transaction.paid?
      fund.amount -= transaction.amount
    else
      update_pending_fund(fund, transaction.term_id, transaction.amount)
    end

    # Need to fix this if multiple funds contribute to a budget category amount
    id = term.options[transaction.category][:budgeted_amount].first[0]
    update_contributor_fund(id, term.date, transaction.amount)
  end

  def update_pending_fund(fund, term_id, amount)
    term = Term.find(term_id)
    fund.components['Pending'][term.date] ||= 0.0
    fund.components['Pending'][term.date] += amount
    fund.save
  end

  def update_contributor_fund(id, date, amount)
    fund = Fund.find(id)
    fund.components['Reserved'][date] -= amount
    if fund.components['Reserved'][date] == 0
      fund.components['Reserved'].delete(date)
    end
    fund.save
  end

  def update_term(transaction)
    term = Term.find(transaction.term_id)
    term.options[transaction.category][:amount_spent] += transaction.amount
    term.save
  end

  def transaction_params
    params.require(:transaction).permit(:date, :description, :amount,
                                        :category, :term_id, :fund_id,
                                        :transaction_type, :paid)
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = 'Please log in first.'
    redirect_to root_path
  end
end
