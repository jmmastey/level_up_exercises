Feature: Show available bomb methods
  I am Overlord
  Memory fails me once more
  Teach me to command

  @javascript
  Scenario: Show all methods
    Given I am on the home page
      When I fill in ".query-input" with "help"
      And I press "Submit Query"
      And I wait for ajax request to finish
      Then I should see "For more information on a specific command" within ".console"
