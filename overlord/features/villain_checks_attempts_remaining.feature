Feature: villain checks attempts remaining

  As a villain
  I want to know how many attempts I have remaining
  So that I don't blow myself up

  @javascript
  Scenario: report number of attempts
    Given I have already activated the bomb
    And I have attempted to deactivate it 1 time
    When I press "Show attempts remaining"
    Then I should see "Attempts remaining: 2"