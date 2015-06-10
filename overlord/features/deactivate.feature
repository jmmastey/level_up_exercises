Feature: Deactivate
  As a user
  I want to be able to deactivate the bomb
  In order to save the world (cheerleader)

  Scenario: Deactivate Success: Default
    Given I have a newly active default bomb
    And I am on the bomb page
    When I use 0000 on the bomb
    Then I should see an inactive bomb

  Scenario: Deactivate Success: Custom
    Given I have a newly active bomb with a deactivation code of "DARBY"
    And I am on the bomb page
    When I use "DARBY" on the bomb
    Then I should see an inactive bomb

  Scenario: Deactivate Failure: Decrement Counter Default
    Given I have a newly active default bomb
    And I am on the bomb page
    When I use 2222 on the bomb
    Then I should see an active bomb with 2 attempts remaining

  Scenario: Deactivate Failure: Decrement Counter Custom
    Given I have a newly active bomb with a deactivation code of "DARBY"
    And I am on the bomb page
    When I use 0000 on the bomb
    Then I should see an active bomb with 2 attempts remaining

  Scenario: Deactivate Failure: Explode
    Given I have a active default bomb
    And I am on the bomb page
    And the bomb has 1 attempt remaining
    When I use 2222 on the bomb
    Then I should see an explosion
    