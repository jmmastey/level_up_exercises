Feature: Boot up bomb
  In order to verify that the bomb can properly be started up
  As a supervillian
  I should be able to boot up the bomb

  Scenario: Not Booting up the bomb
    Given I visit the home page
    When I do nothing
    Then the bomb should be off

  Scenario: Booting up the bomb
    Given I visit the home page
    When I boot up the bomb
    Then the bomb should be on

  Scenario: Booting up the bomb with activation code configured
    Given I visit the home page
    When I configure the activation code to be 0987
    And I boot up the bomb
    Then the bomb should be on

  Scenario: Booting up the bomb with deactivation code configured
    Given I visit the home page
    When I configure the deactivation code to be 1111
    And I boot up the bomb
    Then the bomb should be on

  Scenario: Booting up the bomb with activation and deactivation codes configured
    Given I visit the home page
    When I configure the activation code to be 0987
    And I configure the deactivation code to be 1111
    And I boot up the bomb
    Then the bomb should be on
