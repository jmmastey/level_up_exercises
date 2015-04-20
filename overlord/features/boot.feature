Feature: install a bomb
  In order activate or deactivate the bomb
  As a super villian
  I want to install the bomb

Background:
  Given I have a bomb

  Scenario: configure the bomb with valid codes
    Given I enter valid activation code
    And I enter valid deactivation code
    When I boot the bomb
    Then the bomb should be inactive

  Scenario: configure the bomb with default codes
    When I boot the bomb
    Then the bomb should be inactive

  Scenario: configure the bomb with invalid codes
    Given I enter invalid activation code
    And I enter invalid deactivation code
    When I boot the bomb
    Then I should see an error
