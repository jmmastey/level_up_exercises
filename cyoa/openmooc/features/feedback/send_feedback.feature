Feature: User feedback
  As a user, I would like submit suggestions
  and send help requests

  @LoggedIn
  Scenario: I submit a suggestion
    Given I am on the feedback page
    When I submit a feedback form
    Then I should see a feedback confirmation

  Scenario: Not signed in submit
    Given I am on the feedback page
    Then I should see sign in required
