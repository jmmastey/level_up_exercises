Feature: Disarming the bomb
  As an evil super villian with ambitious objectives and limited finance
  I want to be able to disarm the armed bomb
  So I can make a last-minute decision to choose a better target
  And so super heros have a way to foil my plans to make better movies

Scenario: Visit bomb disarming controls
  Given the bomb is armed
  When I visit the bomb controls
  Then I see the disarming controls

Scenario: Enter correct disarming code to disarm bomb
  Given the bomb is armed
  And I am viewing the bomb disarming controls
  When I enter the registered disarming code
  Then I see the bomb is disarmed

Scenario: Enter incorrect disarming code to disarm bomb
  Given the bomb is armed
  And I am viewing the bomb disarming controls
  When I enter an unregistered disarming code
  Then I see the bomb is armed
