require 'spec_helper'
require_relative 'user_helper'

describe User do
  let(:user) { create_user('Kevin Kline', 'coolguy@besthost.com') }
  let(:events) { create_events_with_showings }
  let(:event) { events[0] }
  let(:showing) { event.showings[0] }
  let(:user_with_showings) do
    user = create_user("Kevin Spacey", 'goodactor@besthost.com')
    events.each { |event| user.add_showing(event.showings.first) }
    user
  end

  it "can add a new showing to its list and grow user's showings" do
    expect { user.add_showing(showing) }.to change{ user.showings.count }.from(0).to(1)
  end

  it "can add a new showing to its list and grow showing's users" do
    expect { user.add_showing(showing) }.to change{ showing.users.count }.from(0).to(1)
  end

  it "can delete an showing from its list and shrink user's showings" do
    expect { user_with_showings.remove_showing(showing) }.to change{ user_with_showings.showings.count }.from(3).to(2)
  end

  it "can delete an showing from its list and shrink showings's users" do
    user_with_showings
    expect { user_with_showings.remove_showing(showing) }.to change{ showing.users.count }.from(1).to(0)
  end

  it 'knows when it has a showing in an event' do
    user_with_showings
    expect(user_with_showings).to have_showing_in(event)
  end

  it 'knows when it does not have a showing in an event' do
    user
    expect(user).not_to have_showing_in(event)
  end

  it "will not add duplicate showings" do
    user_with_showings
    expect { user_with_showings.add_showing(showing) }.not_to change{ user_with_showings.showings.count }
  end
end
