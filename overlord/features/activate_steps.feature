Feature: Activation
  In order to start the bomb countdown
  As a villian
  I want to enter an activation code

  Scenario: Visit home page
    Given I am on the activate bomb page
    When Code 1234 Entered
    Then I see the countdown start


