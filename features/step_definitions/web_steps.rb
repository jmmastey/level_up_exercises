require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )click "([^\"]*)"?$/ do |button|
  click_button(button)
end

When /^(?:|I )fill in "([^\"]*)" with "([^\"]*)"?$/ do |field, value|
  fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^(?:|I )fill in the following(?: within "([^\"]*)")?:$/ do |selector, fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

When /^(?:|I )select "([^\"]*)" from "([^\"]*)"(?: within "([^\"]*)")?$/ do |value, field, selector|
  select(value, :from => field)
end

When /^(?:|I )check "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  check(field)
end

When /^(?:|I )uncheck "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  uncheck(field)
end

When /^(?:|I )choose "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  choose(field)
end

When /^(?:|I )attach the file "([^\"]*)" to "([^\"]*)"(?: within "([^\"]*)")?$/ do |path, field, selector|
  attach_file(field, path)
end

Then /^(?:|I )should see JSON:$/ do |expected_json|
  require 'json'
  expected = JSON.pretty_generate(JSON.parse(expected_json))
  actual   = JSON.pretty_generate(JSON.parse(response.body))
  expected.should == actual
end

Then /^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should see \/([^\/]*)\/(?: within "([^\"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )should not see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/(?: within "([^\"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^the "([^\"]*)" field(?: within "([^\"]*)")? should contain "([^\"]*)"$/ do |field, selector, value|
  field = find_field(field)
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  if field_value.respond_to? :should
    field_value.should =~ /#{value}/
  else
    assert_match(/#{value}/, field_value)
  end
end

Then /^the "([^\"]*)" field(?: within "([^\"]*)")? should not contain "([^\"]*)"$/ do |field, selector, value|
  field = find_field(field)
  field_value = (field.tag_name == 'textarea') ? field.text : field.value
  if field_value.respond_to? :should_not
    field_value.should_not =~ /#{value}/
  else
    assert_no_match(/#{value}/, field_value)
  end
end

Then /^the "([^\"]*)" checkbox(?: within "([^\"]*)")? should be checked$/ do |label, selector|
  field_checked = find_field(label)['checked']
  if field_checked.respond_to? :should
    field_checked.should == 'checked'
  else
    assert_equal 'checked', field_checked
  end
end

Then /^the "([^\"]*)" checkbox(?: within "([^\"]*)")? should not be checked$/ do |label, selector|
  field_checked = find_field(label)['checked']
  if field_checked.respond_to? :should_not
    field_checked.should_not == 'checked'
  else
    assert_not_equal 'checked', field_checked
  end
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}

  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^show me the page$/ do
  save_and_open_page
end
