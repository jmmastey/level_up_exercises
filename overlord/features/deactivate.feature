Feature: Deactivate
  As a user
  I want to be able to deactivate the bomb
  In order to save the world (cheerleader)

  Scenario: Deactivate Success: Default
    Given I have a newly active default bomb
    And I am on the bomb page
    When I use 0000 on the bomb
    Then I should see the status of the bomb as "Inactive"
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer

  Scenario: Deactivate Success: Custom
    Given I have a newly active bomb with a deactivation code of "DARBY"
    And I am on the bomb page
    When I use "DARBY" on the bomb
    Then I should see the status of the bomb as "Inactive"
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer

  Scenario: Deactivate Failure: Decrement Counter Default
    Given I have a newly active default bomb
    And I am on the bomb page
    When I use 2222 on the bomb
    Then I should see the status of the bomb as "Active"
    And I should see the remaining defusal attempts is 2
    And I should see a bomb timer

  Scenario: Deactivate Failure: Decrement Counter Custom
    Given I have a newly active bomb with a deactivation code of "DARBY"
    And I am on the bomb page
    When I use 0000 on the bomb
    Then I should see the status of the bomb as "Active"
    And I should see the remaining defusal attempts is 2
    And I should see a bomb timer

  Scenario: Deactivate Failure: Explode
    Given I have a active default bomb
    And I am on the bomb page
    And the bomb has 1 attempt remaining
    When I use 2222 on the bomb
    Then I should not see the status of the bomb
    And I should not see the remaining defusal attempts
    And I should not see a bomb timer
    And I should not be able to click any buttons
    And I should see an eplosion
