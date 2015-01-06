Feature: Boot the bomb
  In order to control a bomb
  As a super villain
  I want to boot the bomb safely

  Scenario: Boot the bomb without activating
    Given I have not booted the bomb
    When I boot the bomb
    Then the bomb should not be activated