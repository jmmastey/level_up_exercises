def path(path)
  case(path)
  when 'Home'
    '/'
  when 'Sign up'
    '/users/sign_up'
  when 'Log in'
    '/users/sign_in'
  when 'Forgot your password'
    '/users/password/new'
  else
    "/#{path.parameterize.underscore}"
  end
end

def path_with_id(path, id)
  "/#{path.parameterize.underscore}/#{id}"
end

def assert_path(path)
  current_path = URI.parse(current_url).path
  expect(current_path).to eq(path)
end

def clear_cookies(path)
  browser = Capybara.current_session.driver.browser
  if browser.respond_to?(:clear_cookies)
    browser.clear_cookies
  elsif browser.respond_to?(:manage) and browser.manage.respond_to?(:delete_all_cookies)
    browser.manage.delete_all_cookies
  else
    raise "Don't know how to clear cookies. Weird driver?"
  end
end

