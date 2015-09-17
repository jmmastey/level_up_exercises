Feature: A todo list for zone objectives
  As a user
  I want to make a todo list for a zone
  So that I can plan which objectives to do

  Scenario: It should be possible to create a todo list by adding an objective
    Given an empty todo list
    When I add 1 objective to the todo list
    Then the todo list should contain 1 objective

  Scenario: I should be able to add an objective to an existing todo list
    Given a todo list with 1 objective
    When I add 1 objective to the todo list
    Then the todo list should contain 2 objectives

  Scenario: I should be able to remove an objective from an existing todo list
    Given a todo list with 2 objectives
    When I remove 1 objective from the todo list
    Then the todo list should contain 1 objective

  Scenario: An objective removed from a todo list should still be on the page
    Given a todo list with 2 objectives
    When I remove 1 objective from the todo list
    Then I should see the removed objective
