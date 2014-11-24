
def mc_question
  @question ||= FactoryGirl.create(:multiple_choice_question_with_answers)
end

def correct_answer
  'correct answer'
end

def question_params
  { 'Question' => 'Why do we fall?' }
end

### GIVEN ###

Given(/^I am on a multiple choice question page$/) do
  visit(page_path(mc_question.quiz_activity.page))
end

When(/^I enter a correct multiple choice answer submission$/) do
  click_on(correct_answer)
end

When(/^I enter new multiple choice question content$/) do
  enter_form(question_params)
  fill_in('Answer', with: 'hello', match: :first)
end

Then(/^I should be on the multiple choice quiz page$/) do
  expect(current_path).to eq(page_path(mc_question.quiz_activity.page))
end

Then(/^I should see new multiple choice quiz content$/) do
  expect(page).to have_content(question_params['Question'])
end

Then(/^I should see blank multiple choice question content$/) do
  expect(page).to have_content('Question')
  expect(page.find('#multiple_choice_question_page_content_attributes_content'))
    .to have_content('')
end
