require 'rails_helper'

describe TransactionsController do
  before do
    request.env['HTTP_REFERER'] = 'where_i_came_from'
  end

  describe 'POST' do
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      session[:user_id] = user.id
    end

    it 'does not save new transaction with missing attributes that are required' do
      expect { post :create, transaction: { date: Date.new(2015, 1, 1) } }.to_not change { Transaction.count }
      expect { post :create, transaction: { amount: 10.85 } }.to_not change { Transaction.count }
      expect { post :create, transaction: { transaction_type: 'expense' } }.to_not change { Transaction.count }
      expect { post :create, transaction: { term_id: 1 } }.to_not change { Transaction.count }
      expect(response).to redirect_to 'where_i_came_from'
    end
  end
end
