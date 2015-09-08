require 'rails_helper'

describe FundsController do
  before do
    request.env['HTTP_REFERER'] = 'where_i_came_from'
  end

  describe 'POST' do
    before :each do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
    end

    it 'successfully creates a new fund with valid attributes' do
      expect { post :create, fund: FactoryGirl.attributes_for(:bank_fund) }.to change { Fund.count }.by(1)
      expect(response).to redirect_to 'where_i_came_from'
    end

    it 'does not save new fund with missing attributes that are required' do
      expect { post :create, fund: { name: 'Test Fund' } }.to_not change { Fund.count }
      expect { post :create, fund: { amount: 10.85 } }.to_not change { Fund.count }
      expect(response).to redirect_to 'where_i_came_from'
    end

    it 'does not save new fund with duplicate name' do
      post :create, fund: FactoryGirl.attributes_for(:bank_fund)
      expect { post :create, fund: FactoryGirl.attributes_for(:bank_fund) }.to_not change { Fund.count }
      expect(response).to redirect_to 'where_i_came_from'
    end
  end

  describe 'PUT' do
    before :each do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
      @fund = FactoryGirl.create(:bank_fund)
    end

    it 'successfully updates a fund with valid attributes' do
      put :update, id: @fund.id, name: 'Updated Fund', amount: 126.32
      @fund.reload
      expect(@fund.name).to eq('Updated Fund')
      expect(@fund.amount).to eq(126.32)
      expect(@fund.user_id).to eq(@user.id)
      expect(response).to redirect_to '/funds'
    end

    it 'does not update a fund with invalid attributes' do
      FactoryGirl.create(:bank_fund, name: 'Other Fund')
      put :update, id: @fund.id, name: 'Other Fund'
      @fund.reload
      expect(@fund.name).to eq('Bank Fund')
      expect(@fund.user_id).to eq(@user.id)
      expect(response).to redirect_to '/funds'
    end
  end

  describe 'DELETE' do
    it 'successfully deletes the fund' do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
      @fund = FactoryGirl.create(:bank_fund)
      expect { delete :destroy, id: @fund }.to change { Fund.count }.by(-1)
      expect(response).to redirect_to '/funds'
    end
  end
end
