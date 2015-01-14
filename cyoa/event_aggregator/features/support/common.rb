require "rspec/expectations"
require "uri"

DEFAULT_USERNAME = 'Jack'

URL_NICKNAMES =
{
  'login' => '/users/sign_in',
  'about us' => '/about-us',
  'contact us' => '/contact-us',
  'privacy policy' => '/privacy-policy',
  'sign up' => '/users/sign_up',
  'home' => '/',
  'my feeds' => '/my-feeds',
  'not this person' => '/users/sign_out',
  'the customer service phone number' => EventAggregator.customer_service_telno,
  'the customer service e-mail address' => EventAggregator.customer_service_email,
  'the login page' => '/users/sign_in',
  'create new feed' => '/feeds/new',
  'edit feed' => '/feeds/\d+/edit'
}

def url_by_nickname(url_nickname)
  URL_NICKNAMES[url_nickname.downcase] || raise("No such URL #{url_nickname}")
end

ELEMENT_NICKNAMES =
{
  'email' => 'user_email',
  'password' => 'user_password',
  'password confirmation' => 'user_password_confirmation',
  'first name' => 'user_first_name',
  'last name' => 'user_last_name',
  'feed title' => 'feed_title',
  'feed description' => 'feed_description',
}

def id_by_nickname(input_nickname)
  ELEMENT_NICKNAMES[input_nickname.downcase]
end

def element_by_nickname(element_nickname)
  element_id = "\##{id_by_nickname(element_nickname)}"
  find(element_id)
end

def has_major_heading(heading_text)
  rexp = Regexp.new(heading_text)
  page.has_css?('h1,h2,h3,h4', text: rexp)
end

def button(button_label)
  find("input[value*=\"#{button_label}\"]")
rescue
  find(".section-control", text: /#{button_label}/i)
end

def user_password(username)
  username.reverse * 3
end

def user_creation_params(username)
  {
    'email' => "#{username.downcase}@test.me",
    'first_name' => username.capitalize,
    'last_name' => "#{username.downcase.reverse.capitalize}sohn",
    'password' => user_password(username)
  }
end

def model_page_path(action, model_class, find_by_attrs)
  action = action.downcase
  path_helper = "#{model_class}_path".downcase.to_sym
  path_helper = "#{action}_#{path_helper}" unless action =~ /show/
  instance = model_class.find_by(find_by_attrs.symbolize_keys)
  self.send(path_helper, instance)
end

def visit_model_page(action, model_class, find_by_attrs)
  visit(model_page_path(action, model_class, find_by_attrs))
end
