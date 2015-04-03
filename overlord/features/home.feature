Feature: Access bomb console
  Super Villian wants to access bomb console

  Scenario: Dsiplay Bomb console page
    Given Super Villain has access to bomb console
    When Super Villain visits home page
    Then He should see bomb console screen
