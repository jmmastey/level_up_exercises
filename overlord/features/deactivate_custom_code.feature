Feature: Bomb Deactivation with custom code
  As the overlord
  I want to make deactivating the bomb hard
  In order to take over the world

  Scenario Outline: Deactivation with custom code
    Given I am viewing "/"
    And I set the custom codes
    And I enter the correct custom activation code
    When I enter the "deactivate" code <d_code>
    And I click "DEACTIVATE"
    Then bomb status is <status>

    Examples:
    | d_code | status |
    | 0000   | "deactivated" |
    | 1235   | "activated" |
