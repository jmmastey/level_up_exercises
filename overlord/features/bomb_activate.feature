Feature: Activating Bomb
  In order to verify that the bomb can properly be activated and deactivated
  As a supervillian
  I should be able to activate the bomb

  Background: Visit the home page
    Given I visit the home page

  Scenario: Activating the bomb
    Given I use the default activation and deactivation codes
      And I boot up the bomb
    When I activate the bomb with code "1234"
    Then the bomb will be activated

  Scenario: Activating the bomb with custom code
    Given I have a bomb with a custom activation code
    When I activate the bomb
    Then the bomb will be activated

  Scenario: Attempting to activate the bomb with invalid code
    Given I use the default activation and deactivation codes
      And I boot up the bomb
    When I activate the bomb with code "asdg"
    Then the bomb will not be activated
      And I will see "Wrong activation code"
