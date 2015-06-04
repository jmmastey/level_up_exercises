Feature: Boot the bomb
  In order to blow up innocent people
  As the Villian
  I want to boot the bomb

  Scenario: Boot bomb successfully
    Given I have an unbooted bomb
    When I enter code 1234
    Then I see the bomb is booted message

