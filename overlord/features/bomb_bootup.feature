@javascript @bomb_setup
Feature: Boot And Set A Bomb
  In order to prepare bombs
  As a super villain
  I want to boot and set a bomb

  Scenario: I boot a bomb for the first time providing a custom numeric activation code
    Given I am booting a bomb
    And I provide a custom activation code "8888"
    And I create a new bomb
    When the bomb boots
    Then the bomb should not be activated
    And I see a message that a new bomb was created
    And the bomb activation code should be set to 8888

  Scenario: I boot a bomb for the first time without providing a custom activation code
    Given I am booting a bomb
    When I do not provide a custom activation code
    And I create a new bomb
    Then the bomb boots
    And the bomb should not be activated
    And I see a message that a new bomb was created
    And the bomb activation code should be set to 1234

  Scenario: I boot a bomb for the first time providing a custom non numeric activation code
    Given I am booting a bomb
    And I provide a custom activation code "8AA8"
    And I create a new bomb
    Then the bomb should not be activated
    And I see a message that a new bomb was not created

  Scenario: I enter the same activation code for an already activated bomb
    Given I already booted and activated the bomb
    And I am booting a bomb
    And I provide a custom activation code "9999"
    Then the bomb should not be activated
