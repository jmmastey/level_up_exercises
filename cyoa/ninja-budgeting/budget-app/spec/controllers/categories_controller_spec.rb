require 'rails_helper'

describe CategoriesController do
  before do
    request.env['HTTP_REFERER'] = 'where_i_came_from'
  end

  describe 'POST' do
    before :each do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
    end

    it 'successfully creates a new category with valid attributes' do
      expect { post :create, category: FactoryGirl.attributes_for(:category) }.to change { Category.count }.by(1)
      expect(response).to redirect_to 'where_i_came_from'
    end

    it 'does not save new category with missing attributes that are required' do
      expect { post :create, category: { fake_param: 'blah' } }.to_not change { Category.count }
      expect(response).to redirect_to 'where_i_came_from'
    end

    it 'does not save a new category with duplicate name' do
      post :create, category: FactoryGirl.attributes_for(:category)
      expect { post :create, category: FactoryGirl.attributes_for(:category) }.to_not change { Category.count }
      expect(response).to redirect_to 'where_i_came_from'
    end
  end

  describe 'PUT' do
    before :each do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
      @category = FactoryGirl.create(:category)
    end

    it 'successfully updates a category with valid attributes' do
      put :update, id: @category.id, name: 'Updated Category'
      @category.reload
      expect(@category.name).to eq('Updated Category')
      expect(@category.user_id).to eq(@user.id)
      expect(response).to redirect_to '/categories'
    end

    it 'does not update a category with invalid attributes' do
      FactoryGirl.create(:category, name: 'Other Category')
      put :update, id: @category.id, name: 'Other Category'
      @category.reload
      expect(@category.name).to eq('Test Category')
      expect(@category.user_id).to eq(@user.id)
      expect(response).to redirect_to '/categories'
    end
  end

  describe 'DELETE' do
    it 'successfully deletes the category' do
      @user = FactoryGirl.create(:user)
      session[:user_id] = @user.id
      @category = FactoryGirl.create(:category)
      expect { delete :destroy, id: @category }.to change { Category.count }.by(-1)
      expect(response).to redirect_to '/categories'
    end
  end
end
