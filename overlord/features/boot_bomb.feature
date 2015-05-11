Feature: boot the bomb

  In order to operate the bomb
  As the Overlord
  I should set the activation and deactivation codes.

  Scenario: boot the bomb
    Given I am on the bomb home page
    When I boot the bomb
    Then I am prompted to provide activation and deactivation codes
  
  @wip
  Scenario: enter valid activation and deactivation codes
    Given I am on the bomb home page
    And I boot the bomb
    When I submit valid codes
    Then I see the bomb has successfully booted
    And I see a prompt to enter activation code

  @wip
   Scenario: enter invalid activation and deactivation codes                  
     Given I am on the bomb home page                          
     And I boot the bomb
     When I submit invalid codes
     Then I see the bomb did not successfully boot