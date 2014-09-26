Feature: Bomb Actions
  In order to test the Bomb class
  As a developer who wrote Bomb
  I want to ensure the bomb can be activated, deactivated, snipped and detonated correctly

  Scenario: Create a default bomb and ensure it is inactive
    Given I create a bomb with no code
    Then I should see it is not active

  Scenario: Activate a default bomb with correct code
    Given I create a bomb with no code
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

  Scenario: Deactive with wrong code three times
    Given I activate a bomb
    When I attempt unsuccessfully to deactivate it 3 times
    Then I should see it exploded

  Scenario: Deactive with wrong code two times
    Given I activate a bomb
    When I attempt unsuccessfully to deactivate it 2 times
    Then I should see it not exploded

