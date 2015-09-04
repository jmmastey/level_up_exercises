require 'rails_helper'

describe TermsController do
  before do
    request.env['HTTP_REFERER'] = 'where_i_came_from'
  end

  describe 'POST' do
    before :each do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
    end

    it 'successfully creates a new term with valid attributes' do
      expect { post :create, term: FactoryGirl.attributes_for(:term) }.to change { Term.count }.by(1)
      expect(response).to redirect_to 'where_i_came_from'
    end

    it 'does not save new term with missing attributes that are required' do
      expect { post :create, term: { month: 8 } }.to_not change { Term.count }
      expect { post :create, term: { year: 2015 } }.to_not change { Term.count }
      expect(response).to redirect_to 'where_i_came_from'
    end
  end

  describe 'PUT' do
    before :each do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
      @term = FactoryGirl.create(:term)
    end

    it 'does not update the month or year on a valid update' do
      put :update, id: @term.id, term: { month: 5, year: 2000 }
      @term.reload
      expect(@term.month).to eq(1)
      expect(@term.year).to eq(Time.now.year)
      expect(response).to redirect_to '/terms'
    end
  end

  describe 'DELETE' do
    it 'successfully deletes the term' do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
      @term = FactoryGirl.create(:term)
      expect { delete :destroy, id: @term }.to change { Term.count }.by(-1)
      expect(response).to redirect_to '/terms'
    end
  end
end
