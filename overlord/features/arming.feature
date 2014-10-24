Feature: Arming the Bomb
  As an evil super villian who likes explosions
  I want to be able to arm the bomb
  So it is ready to explode

Scenario: Enter correct arming code to arm bomb
  Given the bomb has activation codes registered
  And I am viewing the arming authorization controls
  And the bomb is disarmed
  When I enter the registered arming code
  Then I see an arming confirmation button
  And a detonation delay timer control
  And I can arm the bomb

Scenario: Arming the bomb
  Given I can arm the bomb
  When I enter a detonation delay timer
  And I push the arming confirmation button
  Then I see the bomb is armed
  And I see the detonation delay timer counting down

Scenario: Enter incorrect arming code to arm bomb
  Given the bomb has activation codes registered
  And I am viewing the bomb arming controls
  And the bomb is disarmed
  When I enter an unregistered arming code
  Then I see the bomb is disarmed
