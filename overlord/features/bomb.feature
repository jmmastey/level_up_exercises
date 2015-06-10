Feature: Login
  In order to keep my bomb secure
  As a villain
  I should have different permissions for each user

  Background:
    Given following users exist:
      | username   |
      | villain    |
      | dev        |

  Scenario: Redirect to Login
    Given I am not logged in
    And I am not on the home page
    Then I should be redirected to the home page
    And I should not be logged in

  Scenario Outline: Login Redirects
    Given following users exist:
      | username   |
      | villain    |
      | dev        |
    And I am not logged in
    When I login as <username>
    Then I should be redirected to the <redirect> page
    And I should <bomb_vision> see the bomb
    And I should be logged in as <user>

    Examples:
      | username | redirect | bomb_vision | user    |
      | villain  | bomb     |             | villian |
      | dev      | bomb     |             | dev     |
      | face     | home     | not         |         |

  Scenario Outline: Boot Bomb
    Given




  @Boot
  Scenario: Inactive Initializer
    Given I am a new user
    And I create a default bomb
    Then I should see an "Inactive" bomb


  #Background:
#  Given I create a default bomb => {
#
#    Given I am a new user => visit('/')
#    And I click the boot button => find('boot').click
#    And I click the confirm boot button => find('boot').click
  
#  }



  @Activation_Code
  Scenario: Initialization without activiation code
    Given I am on the home page
    And no activiation code is sepcified
    Then the activiation code of the bomb should be 1234

  Scenario: Initialization without activiation code
    Given I create a bomb
    And no activiation code is sepcified
    Then the activiation code of the bomb should be 1234

  Scenario: Initialization with activitation code
    Given I create a bomb
    And the given activiation code is valid
    Then the activation code of the bomb should be the given activation code

  Scenario: Activate Inactive Bomb
    Given I am on the home page
    And the state of the bomb is "Inactive"
    And I enter the correct acitivation code
    And I accept the confirmation of the activation
    Then the state of the bomb should be "Active"

  Scenario: Activate Inactive Bomb
    Given I am on the home page
    And the state of the bomb is "Inactive"
    And I enter the correct acitivation code
    And I decline confirmation of the activation
    Then the state of the bomb should be "Active"

  Scenario: Activate Active Bomb
    Given I am on the home page
    And the state of the bomb is "Active"
    And I enter the correct activation code
    Then nothing should happen

  @Deactivation_Code
  Scenario: Initialization without dactiviation code
    Given I create a bomb
    And no dactiviation code is sepcified
    Then the dactiviation code of the bomb should be 0000

  Scenario: Initialization with deactivitation code
    Given I create a bomb
    And the given deactiviation code is valid
    Then the deactivation code of the bomb should be the given deactivation code

  Scenario: Deactivate Inactive Bomb
    Given I am on the home page
    And the state of the bomb is "Active"
    And I enter the correct deacitivation code
    Then the state of the bomb should be "Inactive"

  Scenario: Instability Increase
    Given I am on the home page
    And the state of the bomb is "Active"
    And I enter an invalid deactivation code
    And the instability of the bomb is less than 3
    Then the instability of the bomb should increase by one

  Scenario: Bomb Explosion from Instability
    Given I am on the home page
    And the state of the bomb is "Active"
    And I enter an invalid deactivation code
    And the instability of the bomb is 3 or more
    Then the bomb should explode
    And none of the buttons should work anymore

  @Timer
  Scenario: Bomb Timer
    Given I am on the home page
    And the state of the bomb is "Active"
    Then I should see the timer of the bomb



