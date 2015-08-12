Given(/^I am on the homepage$/) do
  visit(root_path)
end

When(/^I search for the artist "(.*?)" at a depth (\d+)$/) do |artist, depth|
  fill_in('name', with: artist)
  fill_in('depth', with: depth.to_i)
  click_button('Submit')
end

Then(/^I should see a graph$/) do
  has_nodes = page.evaluate_script("typeof nodes !== 'undefined'")
  has_edges = page.evaluate_script("typeof edges !== 'undefined'")
  is_graph = has_nodes && has_edges
  expect(is_graph).to be true
end

Then(/^I should see that "(.*?)" is not on spotify$/) do |artist|
  expect(page.html).to include(artist + ' could not be found')
end

Then(/^I should see no error messages$/) do
  expect(page.html).not_to include('could not be found as a Spotify artist.')
end

Then(/^I should see "(.*?)" as a related artist of "(.*?)"$/) do |to, from|
  expect(edge_exists?(from, to)).to be true
end

Then(/^I should see no related artists$/) do
  edges_zero = page.evaluate_script('edges.length')
  expect(edges_zero).to equal 0
end

# Helpers ######################################################################

def get_node_id(name)
  nodes = page.evaluate_script('nodes._data')
  name_id = -1
  nodes.each do |key, value|
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
  edges.each do |key, value|
    edge_exists = true if value['from'] == from_id && value['to'] == to_id
    break if edge_exists
  end
  edge_exists
end