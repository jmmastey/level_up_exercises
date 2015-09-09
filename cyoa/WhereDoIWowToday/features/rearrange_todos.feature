Feature: Rearrange todo list items
  As a user
  I want to control the order of items in the todo list
  So that I can plan the order I will do things

  Scenario: Newly added items should go at the end of the list
    Given a todo list with 2 objectives
    When I add 1 objective to the todo list
    Then the new objective should be at the end of the todo list

  Scenario: I should be able to move an item to the beginning of the list
    Given a todo list with 2 objectives
    When I move the last objective to the beginning of the todo list
    Then the moved objective should be at the beginning of the todo list

  Scenario: Moving a list item should not affect the other relative orders
    Given a todo list with 3 objectives
    When I move the last objective to the beginning of the todo list
    Then the unmoved objects should retain their relative order