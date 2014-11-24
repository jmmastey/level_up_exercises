
def new_question_params
  { 'Question' => 'Why do we fall?',
    'Answer' => 'To learn to pick ourselves back up again.' }
end

def changed_question_params
  { 'Question' => "End? No, the journey doesn't end here.
    Death is just another path, one that we all must take.
    The grey rain-curtain of this world rolls back,
    and all turns to silver glass, and then you see it'" }
end

def wrong_answer_params
  { 'Answer' => 'Wrong Answer' }
end

def right_answer_params
  { 'Answer' => 'Test Answer' }
end

def fitb_question
  @question ||= FactoryGirl.create(:fill_in_the_blank_question_with_answers)
end

### GIVEN ###

Given(/^I am on a fill in the blank question page$/) do
  visit(page_path(fitb_question.quiz_activity.page))
end

### WHEN ###

When(/^I enter new fill in the blank question content$/) do
  enter_form(new_question_params)
end

When(/^I enter a correct answer submission for fill in the blank question$/) do
  enter_form(right_answer_params)
end

When(/^I enter a wrong answer submission for fill in the blank question$/) do
  enter_form(wrong_answer_params)
end

When(/^I change the fill in the blank question data$/) do
  enter_form(changed_question_params)
end

### THEN ###

Then(/^I should see the fill in the blank question changes$/) do
  expect(page).to have_content(changed_question_params['Question'])
end

Then(/^I should see a new quiz page$/) do
  expect(page).to have_content(new_question_params['Question'])
end

Then(/^I should be on the fill in the blank question page$/) do
  expect(current_path).to eq(page_path(fitb_question.quiz_activity.page))
end

Then(/^I should see fill in the blank question content$/) do
  expect(page).to have_content(fitb_question['Question'])
end
