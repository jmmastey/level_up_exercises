Feature: Deactivating Bomb
  In order to verify that the bomb can properly be deactivated
  As a superhero
  I should be able to deactivate the bomb

  Background: Visit the home page
    Given I visit the home page

  Scenario: Deactivating the bomb
    When I boot up the bomb
    And I activate the bomb with code "1234"
    And I deactivate the bomb with code "0000"
    Then the bomb will be deactivated

  Scenario: Deactivating the bomb with custom code
    Given I have a bomb with a custom deactivation code
    When I activate the bomb
      And I deactivate the bomb
    Then the bomb will be deactivated

  Scenario: Attempting to deactivate the bomb with custom code
    When I configure the deactivation code to be "asdf"
    And I boot up the bomb
    Then I will see "Your activation and deactivation codes are invalid."

  Scenario: Activating and deactivating with custom codes
    Given I have a bomb with custom activation and deactivation codes
    When I activate the bomb
      And I deactivate the bomb
    Then the bomb will be deactivated
