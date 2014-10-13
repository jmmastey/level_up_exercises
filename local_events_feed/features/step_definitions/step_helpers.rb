def create_user(name = 'John Smith', email = 'jsmith@besthost.com', password = 'pass-me', confirm = 'pass-me')
  @user ||= User.create(name: name,
                        email: email,
                        password: password,
                        password_confirmation: confirm)
end

def user_signs_in
  visit_signin_page
  create_user
  fill_in('Email', with: @user.email)
  fill_in('Password', with: @user.password)
  click_button("Sign-In")
end

def create_events
  create_event("Party A", "North Side", "2014-10-01T18:00:00", "www.party.com/party-a.html")
  create_event("Party B", "South Side", "2014-10-02T19:00:00", "www.party.com/party-b.html")
  create_event("Party C", "East Side", "2014-10-03T20:00:00", "www.party.com/party-c.html")
end

def create_more_events
  create_event("Party D", "North Side", "2014-10-01T18:00:00", "www.party.com/party-d.html")
  create_event("Party E", "South Side", "2014-10-02T19:00:00", "www.party.com/party-e.html")
end

def create_event(name, location, time, link)
  Event.create(name: name,
               location: location,
               time: time,
               link: link)
end

def user_events
  Event.all.select { |event| @user.events.include?(event) }
end

def non_user_events
  Event.all.select { |event| !@user.events.include?(event) }
end

def a_user_event
  user_events[0]
end

def a_non_user_event
  non_user_events[0]
end

def remove_link_id(event)
  "remove-#{event.id}"
end

def add_link_id(event)
  "add-#{event.id}"
end

def user_page_msg(name)
  "#{name}'s Events"
end

def add_events_to_user
  create_events
  create_user
  Event.all.each { |event| @user.add_event(event) }
end

def find_event(name)
  Event.find_by(name: name)
end
