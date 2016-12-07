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
  create_event("Party A", "North Side", "www.party.com/party-a.html", [eight_oclock, nine_oclock, ten_oclock])
  create_event("Party B", "South Side", "www.party.com/party-b.html", [eight_oclock])
  create_event("Party C", "East Side", "www.party.com/party-c.html", [nine_oclock, ten_oclock])
end

def create_more_events
  create_event("Party D", "North Side", "www.party.com/party-d.html", [nine_oclock])
  create_event("Party E", "South Side", "www.party.com/party-e.html")
end

def create_event(name, location, link, showing_times = [])
  event = Event.create(name: name, location: location, link: link)
  showing_times.each { |time| event.showings.create(time: time) }
  event
end

def user_events
  Event.all.select { |event| @user.has_showing_in?(event) }
end

def non_user_events
  Event.all.select { |event| !@user.has_showing_in?(event) }
end

def a_user_showing
  user_events.first.showings.first
end

def a_non_user_showing
  user_events.first.showings.last
end

def remove_link_id_user_show(showing)
  "remove-#{showing.id}-user-show"
end

def remove_link_id_event_show(showing)
  "remove-#{showing.id}-event-show"
end

def add_link_id(showing)
  "add-#{showing.id}"
end

def user_page_msg(name)
  "#{name}'s Events"
end

def add_showings_to_user
  Event.all.each { |event| @user.add_showing(event.showings.first) }
end

def find_event(name)
  Event.find_by(name: name)
end

def eight_oclock
  DateTime.parse("20141001T080000")
end

def nine_oclock
  DateTime.parse("20141001T090000")
end

def ten_oclock
  DateTime.parse("20141001T100000")
end
