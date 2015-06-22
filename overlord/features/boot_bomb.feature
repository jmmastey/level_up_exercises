Feature: boot the bomb

  As a super villain
  I want to be able to choose activation and deaction codes
  so I can boot my bomb

  Scenario: verify default values
    Given that I am on the boot page
    Then I should see an activation code text box prefilled with an activation code 1234
    And  I should see a deactivation text box prefilled with a deactivation code 0000

  Scenario:enter valid activation and deactivation codes
    Given that I am on the boot page
    When I submit invalid codes
    Then I should see an error message
    When  I submit valid codes
    Then  my bomb should boot successfully
