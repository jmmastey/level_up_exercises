Feature: As a user I would like for links to only be
  appropiate for when I am signed in and not

  @LoggedIn
  Scenario: If logged in and on about page
    display search courses link
    Given I am on the about page
    When I click "Enroll in a course"
    Then I should be on the courses page

  Scenario: If not logged in and on about page
    display sign up link
    Given I am on the about page
    When I click "Sign up to enroll in a course"
    Then I should be on the sign up page

  @LoggedIn
  Scenario: If logged in and on help page
    display send feed back link
    Given I am on the help page
    When I click "Send feedback"
    Then I should be on the feedback page

  Scenario: If not logged in and on help page
    display sign up link
    Given I am on the help page
    When I click "Sign in to send feedback"
    Then I should be on the sign in page
