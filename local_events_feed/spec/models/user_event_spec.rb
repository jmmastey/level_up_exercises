require 'spec_helper'
require_relative 'user_helper'

describe User do
  let(:user) { create_user('Kevin Kline', 'coolguy@besthost.com') }
  let(:events) { create_events }
  let(:event) { events[0] }
  let(:user_with_events) do
    events.each { |event| user.add_event(event)}
    user
  end

  it "can add a new event to its list and grow user's events" do
    expect { user.add_event(event) }.to change{ user.events.count }.from(0).to(1)
  end

  it "can add a new event to its list and grow event's users" do
    expect { user.add_event(event) }.to change{ event.users.count }.from(0).to(1)
  end

  it "can delete an event from its list and shrink user's events" do
    expect { user_with_events.remove_event(event) }.to change{ user_with_events.events.count }.from(3).to(2)
  end

  it "can delete an event from its list and shrink event's users" do
    user_with_events
    expect { user_with_events.remove_event(event) }.to change{ event.users.count }.from(1).to(0)
  end
end
