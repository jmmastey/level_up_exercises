Feature: Rearrange goal list items
  As a user
  I want to control the order of items in the goal list
  So that I can plan the order I will do things

  Scenario: Newly added items should go at the end of the list
    Given a goal list with 2 objectives
    When I add an objective to the goal list
    Then the new objective should be at the end of the goal list

  Scenario: I should be able to move an item to the beginning of the list
    Given a goal list with 2 objectives
    When I move the last objective to the beginning of the goal list
    Then the moved objective should be at the beginning of the goal list

  Scenario: Moving a list item should not affect the other relative orders
    Given a goal list with 3 objectives
    When I move the last objective to the beginning of the goal list
    Then the unmoved objects should retain their relative order