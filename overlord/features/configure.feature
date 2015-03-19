Feature: Booting the bomb
  As a super villain
  I want to configure the bomb
  So I can blow stuff up

  Scenario: View the configure page
    Given I have not booted the bomb
    When I visit the home page
    Then I should see a configuration form

  Scenario: Submit an invalid activation code
    Given I am on the configure page
    When I submit an invalid activation code
    Then I should see "You entered an invalid code"

  Scenario: Submit an invalid deactivation code
    Given I am on the configure page
    When I submit an invalid deactivation code
    Then I should see "You entered an invalid code"

  Scenario: Submit invalid activation AND deactivation codes
    Given I am on the configure page
    When I submit an invalid activation and deactivation code
    Then I should see "You entered an invalid code"

  Scenario: Boot bomb with default codes
    Given I am on the configure page
    When I do not enter any codes
    And I click the Save Codes button
    Then I should be on the home page

  Scenario: Boot bomb with custom codes
    Given I am on the configure page
    When I fill in arm_code with "1111"
    And I fill in disarm_code with "2222"
    And I click the Save Codes button
    Then I should be on the home page
