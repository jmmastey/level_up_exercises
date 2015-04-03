Feature: Activate bomb
  Super Villan is all syched-up! "Time to activate the bomb!", he says

  Scenario: Display activate page
    Given Bomb is configured with default codes
    When Super Villain visits activate page
    Then He should see bomb activation form

  Scenario: Submit correct activation code
    Given Super Villain is on Activate page
    When Enters correct activation code
    And Clicks Activate
    Then He should see deactivate page

  Scenario: Submit incorrect activation code
    Given Super Villain is on Activate page
    When Enters incorrect activation code
    And Clicks Activate
    Then Error message should be displayed
    
  Scenario: Submit empty activation code
    Given Super Villain is on Activate page
    When Clicks Activate
    Then Error message should be displayed
