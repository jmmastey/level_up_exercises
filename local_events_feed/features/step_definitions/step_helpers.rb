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
  create(:event, name: "Party A", times: [eight_oclock, nine_oclock, ten_oclock])
  create(:event, name: "Party B", times: [eight_oclock])
  create(:event, name: "Party C", times: [nine_oclock, ten_oclock])
end

def create_more_events
  create(:event, name: "Party D", times: [nine_oclock])
  create(:event, name: "Party E")
end

def user_events
  @user.showings.map(&:event)
end

def non_user_events
  Event.all - user_events
end

def a_user_showing
  user_events.first.showings.first
end

def a_non_user_showing
  user_events.first.showings.last
end

def remove_link_id_via_user(showing)
  "remove-#{showing.id}-via-user"
end

def remove_link_id_via_event(showing)
  "remove-#{showing.id}-via-event"
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
