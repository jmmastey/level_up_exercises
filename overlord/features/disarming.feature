Feature: Disarming the bomb
  As an evil super villian with ambitious objectives and limited finance
  I want to disarm the bomb with a disarming code and confirmation sequence
  So I can make a last-minute decision to choose a better target
  But super heros do not have a chance to foil my plans by disarming my bomb

@javascript
Scenario: Visit bomb disarming authorization controls
  Given the bomb is armed
  When I view the bomb controls
  Then I see the disarming authorization controls

@javascript
Scenario: Disarming code without disarming button does not disarm bomb
  Given the bomb is armed
  When I enter the correct disarming code
  But I do not press the "disarming" button
  And I press the "commit" button
  Then I see the bomb is still armed

@javascript
Scenario: Enter incorrect disarming code does not disarm bomb
  Given the bomb is armed
  When I enter an incorrect disarming code
  And I press the "disarming" button
  And I press the "commit" button
  Then I see the bomb is still armed

@javascript
Scenario: Enter correct disarming code and sequence to disarm bomb
  Given the bomb is armed
  When I enter the correct disarming code
  And I press the "disarming" button
  And I press the "commit" button
  Then I see the bomb is disarmed
