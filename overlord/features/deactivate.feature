Feature: Deactivate bomb
    The plan has changed. There was a mole in the org. But he wont be an issue any more.
    Super Villain wants to deactivate the bomb and deploy it at a different location.

    Scenario: Display deactivate page
      Given Bomb is configured with default codes
      And Bomb is active
      When Super Villain is on deactivate page
      Then He should see deactivate form
    
    Scenario: Enter correct deactivation code
      Given Bomb is configured with default codes
      And Bomb is active
      When Super Villain enters correct deactivation code
      And Clicks Deactivate button
      Then He should see activate page
    
    Scenario: Enter incorrect deactivation code
      Given Bomb is configured with default codes
      And Bomb is active
      When Super Villain enters incorrect deactivation code
      And Clicks Deactivate button
      Then Error message displayed
    
    Scenario: Enter incorrect deactivation code 3 times
      Given Bomb is configured with default codes
      And Bomb is active
      When Super Villain enters incorrect deactivation code 3 times
      Then He should see explode page
