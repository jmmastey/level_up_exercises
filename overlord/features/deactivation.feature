Feature: Deactivation
  In order to save the world
  As a potentially malevolent evil overlord
  I should be able to deactivate the bomb

  Scenario: Should not be able to directly jump to the deactivation page
    Given I am on the deactivation page
    Then I should be on the home page

  Scenario: Deactivation page status check
    Given I activated the bomb with the deactivation code ""
    Then I should see "Bomb Status: Active"

  Scenario: Bomb should deactivate with default code
    Given I activated the bomb with the deactivation code ""
    And I fill in "deactivation" with "0000"
    And I press "Deactivate"
    Then I should be on the hero page

  Scenario: Bomb should deactivate with user specified code
    Given I activated the bomb with the deactivation code "8675"
    And I fill in "deactivation" with "8675"
    And I press "Deactivate"
    Then I should be on the hero page

  Scenario Outline: Bomb should correctly deactivate after < 3 repeated attempts
    Given I activated the bomb with the deactivation code ""
    And I unsuccessfully deactivated the bomb <start> times
    And I fill in "deactivation" with "0000"
    And I press "Deactivate"
    Then I should be on the hero page
    Examples:
      | start |
      |  "0"  |
      |  "1"  |
      |  "2"  |

  Scenario: Bomb should blow up after 3 unsuccessful deactivation attempts
    Given I activated the bomb with the deactivation code ""
    And I unsuccessfully deactivated the bomb "3" times
    Then I should be on the blowup page