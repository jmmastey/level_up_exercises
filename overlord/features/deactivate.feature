Feature: Deactivate
  As a user
  I want to be able to deactivate the bomb
  In order to save the world (cheerleader)

  Scenario: Deactivation success: Default
    Given I login as "villain"
    And I boot the bomb
    And I use 1234 on the bomb
    When I use 0000 on the bomb
    Then I should see the status of the bomb is "Inactive"
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer

  Scenario: Deactivation success: Custom
    Given I login as "villain"
    And I enter deactivation code "DARBY"
    And I boot the bomb
    And I use 1234 on the bomb
    When I use "DARBY" on the bomb
    Then I should see the status of the bomb is "Inactive"
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer

  Scenario: Deactivate failure: Decrement counter default
    Given I login as "villain"
    And I boot the bomb
    And I use 1234 on the bomb
    When I use 2222 on the bomb
    Then I should see the status of the bomb is "Active"
    And I should see the remaining defusal attempts is 2
    And I should see a bomb timer

  Scenario: Deactivate failure: Decrement counter custom
    Given I login as "villain"
    And I enter deactivation code "DARBY"
    And I boot the bomb
    And I use 1234 on the bomb
    When I use 0000 on the bomb
    Then I should see the status of the bomb is "Active"
    And I should see the remaining defusal attempts is 2
    And I should see a bomb timer
