Feature: Activating Bomb
  In order to verify that the bomb can properly be activated and deactivated
  As a supervillian
  I should be able to activate the bomb

  Scenario: Activating the bomb
    Given I visit the home page
    When I boot up the bomb
    And I activate the bomb with code "1234"
    Then the bomb will be activated

  Scenario: Activating the bomb with custom code
    Given I visit the home page
    When I configure the activation code to be "0987"
    And I boot up the bomb
    And I activate the bomb with code "0987"
    Then the bomb will be activated

  Scenario: Attempting to activate the bomb with invalid code
    Given I visit the home page
    When I boot up the bomb
    And I activate the bomb with code "asdg"
    Then the bomb will not be activated
      And I will see "Wrong activation code"
