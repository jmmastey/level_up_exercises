Feature: Numeric Activation Codes
  As an evil super villian
  I want configured activation codes required to arm and disarm the bomb
  So that I am the only one who can arm and disarm it

@javascript
Scenario: Visit bomb controls when no activation codes are registered
  Given the bomb has no activation codes registered
  When I see the activation code registration controls
  And I see a field to register an arming code
  And I see a field to register a disarming code

@javascript
Scenario: Register numeric activation codes
  Given the bomb has no activation codes registered
  And I see the activation code registration controls
  When I enter a numeric arming code "3456"
  And I enter a numeric disarming code "4578"
  And I press the "commit" button
  Then I see that activation codes are registered

@javascript
Scenario: Register non-numeric activation codes
  Given the bomb has no activation codes registered
  And I see the activation code registration controls
  When I enter a non-numeric arming code "34T6"
  And I enter a non-numeric disarming code "45G8"
  And I press the "commit" button
  Then I see the bomb has no activation codes registered

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

@javascript
Scenario: Enter incorrect disarming codes three times explodes bomb
  Given the bomb is armed
  When I attempt to disarm bomb with incorrect disarming code 3 times
  Then I see the bomb explode
