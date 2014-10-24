Feature: Numeric Activation Codes
  As an evil super villian
  I want configured activation codes required to arm and disarm the bomb
  So that I am the only one who can arm and disarm it

Scenario: Visit bomb controls when no activation codes are registered
  Given the bomb has no activation codes registered
  When I view the bomb controls
  Then I see the activation code registration controls
  And a field to register an arming code
  And a field to register a disarming code

Scenario: Register numeric activation codes
  Given the bomb has no activation codes registered
  And I am viewing the activation code registration controls
  When I enter a numeric arming code and numeric disarming code
  Then I see that arming and disarming codes are registered

Scenario: Register non-numeric activation codes
  Given the bomb

Scenario: Visit bomb arming authorization controls
  Given the bomb has activation codes registered
  And the bomb is disarmed
  When I view the bomb controls
  Then I see the arming authorization controls

Scenario: Visit bomb disarming authorization controls
  Given the bomb is armed
  And disarming is not authorized
  When I view the bomb controls
  Then I see the disarming authorization controls

Scenario: Enter incorrect disarming codes three times
  Given the bomb is armed
  And I am viewing the bomb disarming controls
  When I enter unregistered disarming codes three consecutive times
  Then I see the bomb explode
