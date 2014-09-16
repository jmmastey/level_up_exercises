Feature: Bomb
  In order to explode bomb
  As a super villain
  I want to enter an activation code and deactivation code

  Scenario: First boot
    Given I am on the home page
    Then I should see "Deactivated" within "#bomb_status"


  Scenario: Activate the bomb with default code
    Given I am on the home page

#    Then the "activation_code" should not contain "*"
    Then the "activation_code" field should not contain "1234"
#    Then the "deactivation_code" should not contain "*"
    And I press :activated within "#numpad"
    Then the bomb should be active

  Scenario: Deactivate bomb with default code
    Given I am on the home page
    And I should see "Active" within "#bomb_status"
    When I fill in "0000" for "deactivation_code"
    Then I press "Deactivate" within "bomb_control"
    Then the bomb should not be active

  Scenario: Activate the bomb with codes
    Given I am on the home page
    Then I should not see "Active" within "#bomb_status"
    When I fill in "4321" for "activation_code"
    Then I fill in "1234" for "deactivation_code"
    When I press "Activate" within "bomb_control"
    Then the bomb should be active

  Scenario: Deactivate bomb with code
    Given I am on the home page
    And I should see "Active" within "#bomb_status"
    When I fill in "1234" for "deactivation_code" within "bomb_control"
    Then I press "Deactivate" within "bomb_control"
    Then the bomb should not be active

  Scenario: Detonate bomb when time runs out
    Given I am on the home page
    And I should see "Active" within "#bomb_status"
    When the "timer" field within "#bomb_status" should contain "00:00:00"
    Then the bomb should explode

  Scenario: Detonate bomb when deactivation code in entered worng three times
    Given I am on the home page
    And I should see "Active" within "#bomb_status"
    When I fill in "wrong_code" for "deactivation_code" within "bomb_control"
    And I press "Deactivate" within "bomb_control"
    When I fill in "wrong_code" for "deactivation_code" within "bomb_control"
    And I press "Deactivate" within "bomb_control"
    When I fill in "wrong_code" for "deactivation_code" within "bomb_control"
    And I press "Deactivate" within "bomb_control"
    Then the bomb should explode

