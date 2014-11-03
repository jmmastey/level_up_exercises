Feature: Arming the Bomb
  As an evil super villian who likes explosions
  I want to arm the bomb with an arming codes and a confirmation sequence
  So it is ready to explode when I want to explode it and not by accident

@javascript
Scenario: Visit bomb arming authorization controls
  Given the bomb has activation codes registered
  And I see the bomb is disarmed
  When I view the bomb controls
  Then I see the arming authorization controls
@javascript

@javascript
Scenario: Enter incorrect arming code does not arm bomb
  Given the bomb has activation codes registered
  When I enter an incorrect arming code
  And I press the "arming" button
  And I press the "commit" button
  Then I see the bomb is still disarmed

@javascript
Scenario: Arming code without arming button does not arm bomb
  Given the bomb has activation codes registered
  When I enter the correct arming code
  But I do not press the "arming" button
  And I press the "commit" button
  Then I see the bomb is still disarmed

@javascript
Scenario: Enter correct arming code and sequence to arm bomb
  Given the bomb has activation codes registered
  When I enter the correct arming code
  And I press the "arming" button
  And I press the "commit" button
  Then I see the bomb is armed
