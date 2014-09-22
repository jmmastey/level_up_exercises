Feature: Booting the Bomb
  In order to take over the world
  As a super villian
  I want a bomb I can boot up with custom or default codes

  Background:
    Given I first arrive at the bomb site

  Scenario: Booting w/ default codes
    When I leave activation and deactivation fields blank
    And I press "boot"
    Then I should see a status of "deactivated"
    And there should be an "activation_code" field

  Scenario: Booting w/ custom codes
    When I enter custom codes 1111 2222
    And I press "boot"
    Then I should see a status of "deactivated"
    And there should be an "activation_code" field

  # ??? How do I test this....
  Scenario: Booting w/ invalid codes
    When I enter custom codes 12345 321
    And I press "boot"
    Then I should stay on the page (not be able to press boot, etc.)
