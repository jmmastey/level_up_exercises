Feature: Debugging information
  As a developer
  I want to have an easy way to see certain pieces of my application state
  So that I can debugg it more easily

  Scenario: I should be able to see an activity
    Given a zone with 1 quest not completed by my character
    When I visit the activity page
    Then I should see the activity details