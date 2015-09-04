# Helpers ######################################################################

def log_in(email, password)
  fill_in('user_email', with: email)
  fill_in('user_password', with: password)
  click_button('Log in')
end

def get_node_id(name)
  nodes = page.evaluate_script('nodes._data')
  name_id = -1
  nodes.each do |_key, value|
    name_id = value['id'] if value['label'] == name
    break if name_id != -1
  end
  name_id
end

def edge_exists?(from, to)
  from_id = get_node_id(from)
  to_id = get_node_id(to)
  edges = page.evaluate_script('edges._data')
  edge_exists = false
  edges.each do |_key, value|
    edge_exists = true if value['from'] == from_id && value['to'] == to_id
    break if edge_exists
  end
  edge_exists
end

def signup(email, password_1, password_2)
  click_link('Sign up')
  fill_in('user_email', with: email)
  fill_in('user_password', with: password_1)
  fill_in('user_password_confirmation', with: password_2)
  click_button('Sign up')
end

def create_user(email, password)
  @user = User.create!(email: email,
                       password: password,
                       password_confirmation: password,
  )
end

def update_email(email)
  visit('/users/edit')
  fill_in('user_email', with: email)
  fill_in('user_current_password', with: @password)
  @email = email
  click_button('Update')
end

def update_password(new_password)
  visit('/users/edit')
  fill_in('user_password', with: new_password)
  fill_in('user_password_confirmation', with: new_password)
  fill_in('user_current_password', with: @password)
  @password = new_password
  click_button('Update')
end

def edit_user_password(password_1, password_2)
  visit('/users/edit')
  fill_in('user_password', with: password_1)
  fill_in('user_password_confirmation', with: password_2)
  fill_in('user_current_password', with: @password)
  click_button('Update')
end

# Algorithm below shamelessly stolen from gist.github.com/michaelglass/8610317

def get_alert_text_from(&block)
  handle_js_modal 'alert', true, true, &block
  get_modal_text 'alert'
end

def get_modal_text(name)
  page.evaluate_script "window.#{name}Msg;"
end

def handle_js_modal(name, return_val, wait_for_call = false, &block)
  modal_called = "window.#{name}.called"
  handle_js_modal_execute_script(name, modal_called, return_val)
  block.call
  wait_for_call(name, modal_called) if wait_for_call
ensure
  page.execute_script "window.#{name} = window.original_#{name}_function"
end

def handle_js_modal_execute_script(name, modal_called, return_val)
  page.execute_script "
      window.original_#{name}_function = window.#{name};
      window.#{name} = function(msg) { window.#{name}Msg = msg; window.#{name}.called = true; return #{!!return_val}; };
      #{modal_called} = false;
      window.#{name}Msg = null;"
end

def wait_for_call(name, modal_called)
  timed_out = false
  timeout_after = Time.now + Capybara.default_wait_time
  loop do
    raise_page_changed if page.evaluate_script(modal_called).nil?
    break if page.evaluate_script(modal_called) ||
        (timed_out = Time.now > timeout_after)
    sleep 0.001
  end
  raise "#{name} should have been called" if timed_out
end

def raise_page_changed
  raise 'appears that page has changed since this method ' \
            'has been called, please assert on page before calling this'
end