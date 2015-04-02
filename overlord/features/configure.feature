Feature: Booting the bomb
  As a super villain
  I want to configure the bomb
  So I can blow stuff up

  Background:
    Given I am on the configure page

  Scenario: Submit an invalid activation code
    When I submit an invalid activation code
    Then I should see "You entered an invalid code"

  Scenario: Submit an invalid deactivation code
    When I submit an invalid deactivation code
    Then I should see "You entered an invalid code"

  Scenario: Submit invalid activation AND deactivation codes
    When I submit an invalid activation and deactivation code
    Then I should see "You entered an invalid code"

  Scenario: Boot bomb with default codes
    When I do not enter any codes
    And I submit the codes
    Then I should be on the home page

  Scenario: Boot bomb with custom codes
    When I submit valid activation and deactivation codes
    Then I should be on the home page
