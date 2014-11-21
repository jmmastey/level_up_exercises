Feature: Abort bomb countdown
  I would like to abort the countdown
  So that I can prevent mass destruction
  And everything will be OK

  Background:
    Given I am on the homepage
    And I have begun the countdown sequence

  @javascript
  Scenario: Abort the countdown sequence
    When I type "deactivate 0000"
    And I enter the query
    Then The countdown sequence should be stopped
    And The bomb should be deactivated
