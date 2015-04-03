Feature: Configure the bomb
  Super Villian wants to configure the bomb
  So he can blow up buildings and train stations and what not

  Scenario: Display config page 
    Given Bomb is not booted
    When Super Villain accesses config page
    Then He should see configuration form

  Scenario: Boot bomb with default codes
    Given Super Villain is on config page
    When Super Villian clicks boot
    Then He should see activate page

  Scenario: Boot bomb with custom codes
    Given Super Villain is on config page
    When Super Villain enters activation code '0101'
    And He enters deactivation code '1010'
    And Clicks Boot
    Then He should see activate page
  
  Scenario: Submit invalid activation code
    Given Super Villain is on config page
    When Super Villain enters invalid activation code
    Then He should see error message
    
  Scenario: Submit invalid deactivation code
    Given Super Villain is on config page
    When Super Villain enters invalid deactivation code
    Then He should see error message
