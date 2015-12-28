Given(/^there are many users$/) do
  @users = {
    private: FactoryGirl.create_list(:named_user, 10),
    public:  FactoryGirl.create_list(:named_user, 10, profile_visible: true),
  }
end

When(/^I visit the user directory$/) do
  visit users_path
end

Then(/^I see (public|private) users' names$/) do |scope|
  @users[scope.to_sym].each do |user|
    expect(page).to have_content(user.full_name)
  end
end

Then(/^I do not see (public|private) users' names$/) do |scope|
  @users[scope.to_sym].each do |user|
    expect(page).not_to have_content(user.full_name)
  end
end
