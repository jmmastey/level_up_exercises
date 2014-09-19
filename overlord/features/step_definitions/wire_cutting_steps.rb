When(/^I cut all disarm wires$/) do
  all(".wire[data-type='disarm']").each(&:click)
end

When(/^I cut an exploding wire$/) do
  first(".wire[data-type='exploding']").click
end

Then(/^the bomb should be disabled$/) do
  expect(find(".activation_status")).to have_content("DISABLED")
end
