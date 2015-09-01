Feature: Deactivation
  In order to save the world
  As a potentially malevolent evil overlord
  I should be able to deactivate the bomb

  Scenario: Should not be able to directly jump to the deactivation page
    Given I am on the deactivation page of the bomb
    Then I should be on the starting page

  Scenario: Deactivation page status check
    Given I activated the bomb with the default codes
    Then The page should say "Bomb Status: Active"

  Scenario: Bomb should deactivate with default code
    Given I activated the bomb with the default codes
    When I try to deactivate the bomb with the default code
    Then I should be on the hero page

  Scenario: Bomb should deactivate with user specified code
    Given I activated the bomb with the user's deactivation code
    When I try to deactivate the bomb with the user's code
    Then I should be on the hero page

  Scenario Outline: Bomb should correctly deactivate after < 3 repeated attempts
    Given I activated the bomb with the default codes
    And I unsuccessfully deactivated the bomb <start> times
    When I try to deactivate the bomb with the default code
    Then I should be on the hero page
    Examples:
      | start |
      |  0    |
      |  1    |
      |  2    |

  Scenario: Bomb should blow up after 3 unsuccessful deactivation attempts
    Given I activated the bomb with the default codes
    And I unsuccessfully deactivated the bomb 3 times
    Then I should be on the blowup page