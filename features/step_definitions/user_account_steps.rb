Given(/^I have (\d+) users$/) do |arg1|
  user_1 = create(:user, first_name: "John", email: "user1@example.com")
  user_2 = create(:user, first_name: "David", email: "user2@example.com")
end
