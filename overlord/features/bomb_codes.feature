Feature: Bomb Codes
  In order to test the Bomb class
  As a developer who wrote Bomb
  I want to ensure the bomb processes codes correctly

  Scenario: Create a default bomb and ensure it is inactive
    Given I create a bomb with default codes
    Then I should see it is not active

  Scenario: Activate a default bomb with correct code
    Given I create a bomb with default codes
    When I activate it with code 1234
    Then I should see it is active

  Scenario: Deactivate a default bomb with correct code
    Given an activated bomb with default codes
    And I deactivate it with code 0000
    Then I should see it is not active

  Scenario: Activate a coded bomb with correct code
    Given I create a bomb with codes 9854 and 0941
    When I activate it with code 9854
    Then I should see it is active

  Scenario: Dectivate a coded bomb with correct code
    Given I create a bomb with codes 9854 and 0941
    When I activate it with code 9854
    And I deactivate it with code 0941
    Then I should see it is not active

  Scenario: Activate a coded bomb with incorrect code
    Given I create a bomb with codes 9854 and 0941
    When I activate it with code 1234
    Then I should see it is not active

  Scenario: Dectivate a coded bomb with incorrect code
    Given I create a bomb with codes 9854 and 0941
    When I activate it with code 9854
    And I deactivate it with code 0000
    Then I should see it is active

  Scenario: Create a bomb with bad activation code, it resorts to default code
    Given I create a bomb with codes ABCD and 0941
    When I activate it with code 1234
    Then I should see it is active

  Scenario: Create a bomb with bad deactivation code, it resorts to default code
    Given I create a bomb with codes 9854 and ABCD
    When I activate it with code 9854
    And I deactivate it with code 0000
    Then I should see it is not active

  Scenario: Activate with a bad code
    Given I create a bomb with codes 9854 and 0941
    When I activate it with code 1234
    Then I should see it is not active

  Scenario: Dectivate with a bad code
    Given I create a bomb with codes 9854 and 0941
    When I activate it with code 9854
    And I deactivate it with code 0000
    Then I should see it is active
