require 'rails_helper'

describe EventsController do
  before(:each)           { controller.stub :authenticate_user! }
  let(:event)             { create :event }

  describe '#index' do
    before do
      get :index
      allow(EventSearch).to receive(:call).and_return([event])
    end

    it 'renders the index template' do
      expect(response).to render_template('events/index')
    end

    it 'assigns the eligible events' do
      expect(assigns(:events)).to eq([event])
    end
  end

  describe '#show' do
    it 'assigns the event' do
      get :show, { id: event.id }
      expect(assigns(:event)).to eq(event)
    end

    it 'doesnt assign if event isnt found' do
      get :show, { id: event.id + 1 }
      expect(assigns(:event)).to be_nil
    end

    it 'renders 404 if event id isnt found' do
      get :show, { id: event.id + 1 }
      expect(response).to render_template('404')
    end
  end

  describe '#new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template('events/new')
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe '#create' do
    let(:test_params) do
      { event: { foo: "test", bar: "test", title: "title", description: "desc" } }
    end

    it 'filter out unpermitted params' do
      allow(CreateEvent).to receive(:create).and_return(nil)
      expect(CreateEvent).to receive(:create).with({ title: "title", description: "desc" })
      get :create, test_params
    end

    it 'should should display flash if event already exists' do
      allow(CreateEvent).to receive(:create).and_return(nil)
      get :create, test_params
      expect(flash[:alert]).to eq("Failed to create event! Event already exists!")
      expect(assigns(:event)).to be_a_new(Event)
    end

    let(:am_errors) { ActiveModel::Errors.new("event") }

    it 'should display a flash if validations failed' do
      allow(CreateEvent).to receive(:create).and_return(event)
      allow(am_errors).to receive(:messages).and_return('error')
      allow(am_errors).to receive(:present?).and_return(true)
      allow(event).to receive(:errors).and_return(am_errors)
      get :create, test_params
      expect(flash[:alert]).to eq("Failed to create event! errors: error")
      expect(assigns(:event)).to be_a_new(Event)
    end

    it 'should display a flash if event was created' do
      allow(CreateEvent).to receive(:create).and_return(event)
      get :create, test_params
      expect(flash[:notice]).to eq("Created event!")
      expect(assigns(:event)).to be_a_new(Event)
      expect(Event.last).to eq(event)
    end
  end

  describe '#edit' do
    it 'renders the edit template' do
      get :edit, { id: event.id }
      expect(response).to render_template('events/edit')
      expect(assigns(:event)).to eq(event)
    end

    it 'doesnt assign if event isnt found' do
      get :edit, { id: event.id + 1 }
      expect(assigns(:event)).to be_nil
    end
  end

  describe '#update' do
    let(:test_params) do
      { id: event.id, event: { foo: "test", bar: "test", title: "title", description: "desc" } }
    end

    it 'filter out unpermitted params' do
      allow(UpdateEvent).to receive(:update).and_return(true)
      expect(UpdateEvent).to receive(:update).with(event, { title: "title", description: "desc" })
      put :update, test_params
    end

    it 'should display a success flash message if event was update' do
      allow(UpdateEvent).to receive(:update).and_return(true)
      put :update, test_params
      expect(flash[:notice]).to eq("Updated event!")
      expect(assigns(:event)).to eq(event)
    end

    it 'should display an error flash message if event wasnt updated' do
      allow(UpdateEvent).to receive(:update).and_return(false)
      put :update, test_params
      expect(flash[:alert]).to eq("Failed to update event!")
      expect(assigns(:event)).to eq(event)
    end
  end
end
