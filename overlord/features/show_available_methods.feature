Feature: Show available bomb methods
  I am Overlord
  Memory fails me once more
  Teach me to command

  @javascript
  Scenario: Show all methods
    Given I am on the home page
      When I type "help"
      And I enter the query
      Then I should see "For more information on a specific command"
