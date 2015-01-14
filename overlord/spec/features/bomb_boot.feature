Feature: Boot the bomb
  In order to control a bomb
  As a super villain
  I want to boot the bomb safely

  @happy
  Scenario: Boot the bomb without activating
    Given I have not booted the bomb
    When I have booted the bomb
    Then the status indicator shows as deactivated