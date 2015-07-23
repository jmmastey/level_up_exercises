Feature: Activating and Deactivating Bomb
  In order to verify that the bomb can properly be activated and deactivated
  As a supervillian
  I should be able to activate and then deactivate the bomb

  Scenario: Activating the bomb
    Given I visit the home page
    When I boot up the bomb
    And I activate the bomb with code 1234
    Then the bomb should be activated

  Scenario: Activating the bomb with custom code
    Given I visit the home page
    When I configure the activation code to be 0987
    And I boot up the bomb
    And I activate the bomb with code 0987
    Then the bomb should be activated

  Scenario: Deactivating the bomb
    Given I visit the home page
    When I boot up the bomb
    And I activate the bomb with code 1234
    And I deactivate the bomb with code 0000
    Then the bomb should be deactivated

  Scenario: Deactivating the bomb with custom code
    Given I visit the home page
    When I configure the deactivation code to be 1111
    And I boot up the bomb
    And I activate the bomb with code 1234
    And I deactivate the bomb with code 1111
    Then the bomb should be deactivated

  Scenario: Activating and deactivating with custom codes
    Given I visit the home page
    When I configure the activation code to be 0987
    And I configure the deactivation code to be 1111
    And I boot up the bomb
    And I activate the bomb with code 0987
    And I deactivate the bomb with code 1111
    Then the bomb should be deactivated