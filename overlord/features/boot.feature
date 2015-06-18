Feature: Boot the bomb
  In order to blow up innocent people
  As the Villian
  I want to boot the bomb

  Scenario: Boot bomb successfully
    Given I have a unbooted bomb 
    When I press the boot bomb button
    #When I enter code 1234
    Then I see the bomb is booted messages

