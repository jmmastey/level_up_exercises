require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do
  let(:valid_attributes) do
    skip("Add a hash of attributes valid for your model")
  end

  let(:invalid_attributes) do
    skip("Add a hash of attributes invalid for your model")
  end

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all items as @items" do
      item = Item.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:items)).to eq([item])
    end
  end

end
