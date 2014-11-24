Feature: As a user I like to submit
  answers to a quiz.

  Scenario:
    Given I am on a multiple choice question page
    When I click "correct answer"
    Then I should see "Great Job!"

  Scenario:
    Given I am on a multiple choice question page
    When I click first "incorrect answer"
    Then I should see "Incorrect response"
