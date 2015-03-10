Feature: Booting the bomb

  Background: Bomb home page
    Given I am on bomb interface page

  Scenario: Check bomb home page
    Then On home page I see activation code box with default code
    And I see deactivation code box with default code
    And I see "Boot" button

  Scenario: I boot bomb with default codes
    When I click "Boot" button
    Then On bomb interface page

  Scenario: I boot bomb with custom codes
    When I set the activation and deactivation code
    And I click "Boot" button
    Then On bomb interface page
