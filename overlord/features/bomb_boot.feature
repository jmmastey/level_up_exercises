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
    When I boot up the bomb with activation code 0987
    Then the bomb should be on
    And the activation code should be set to 0987
    