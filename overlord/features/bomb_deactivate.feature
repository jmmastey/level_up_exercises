Feature: Deactivating Bomb
  In order to verify that the bomb can properly be deactivated
  As a superhero
  I should be able to deactivate the bomb

  Scenario: Deactivating the bomb
    Given I visit the home page
    When I boot up the bomb
    And I activate the bomb with code "1234"
    And I deactivate the bomb with code "0000"
    Then the bomb will be deactivated

  Scenario: Deactivating the bomb with custom code
    Given I visit the home page
    When I configure the deactivation code to be "1111"
    And I boot up the bomb
    And I activate the bomb with code "1234"
    And I deactivate the bomb with code "1111"
    Then the bomb will be deactivated

  Scenario: Attempting to deactivate the bomb with custom code
    Given I visit the home page
    When I configure the deactivation code to be "asdf"
    And I boot up the bomb
    Then I will see "Your activation and deactivation codes are invalid."

  Scenario: Activating and deactivating with custom codes
    Given I visit the home page
    When I configure the activation code to be "0987"
    And I configure the deactivation code to be "1111"
    And I boot up the bomb
    And I activate the bomb with code "0987"
    And I deactivate the bomb with code "1111"
    Then the bomb will be deactivated
