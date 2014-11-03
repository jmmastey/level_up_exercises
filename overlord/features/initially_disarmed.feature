Feature: Initial State
  As a human being who values his own life
  I want the bomb always to start up disarmed and ready to
  register activation codes, with preset defaults
  So I neither instantly die nor arm the bomb with unknown codes

Scenario: Start up initially disarmed
  Given the bomb is not started
  When I start the bomb
  Then I see the bomb is disarmed

Scenario: Start up ready to register with default activation codes
  Given the bomb is not started
  When I start the bomb
  Then I see the activation code registration controls
  And I see the arming code 1234
  And I see the disarming code 0000
