require 'spec_helper'
require_relative 'user_helper'

describe User do
  let(:user) { create_user('Kevin Kline', 'coolguy@besthost.com') }
  let(:events) { create_events }
  let(:user_with_events) do
    events.each { |event| user.add_event(event)}
    user
  end

  it 'can add a new event to its list' do
    expect { user.add_event(events[0]) }.to change{ user.events.count }.from(0).to(1)
  end

  it 'can add a new event to its list' do
    expect { user.add_event(events[0]) }.to change{ user.events.count }.from(0).to(1)
  end

  it 'can delete an event from its list' do
    expect { user_with_events.remove_event(events[0]) }.to change{ user_with_events.events.count }.from(3).to(2)
  end
end
