Feature: Toggle visibility of objectives
  As a user
  I want to hide and unhide objectives
  So that I can concentrate on the objects that interest me the most

  Scenario: I should be able to hide objectives
    Given 3 objectives
    When I hide 1 objective
    Then I should see 2 objectives

  Scenario: I should be able to unhide objectives
    Given 1 hidden objective and 1 visible objective
    When I show all objectives
    Then I should see 2 objectives

  Scenario: Nothing should happen when I try to unhide 0 objectives
    Given 0 hidden objectives and 3 visible objectives
    When I show all objectives
    Then I should see 3 objectives

