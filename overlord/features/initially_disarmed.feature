Feature: Initial State
  As a human being who values his own life
  I want the bomb always to start up disarmed and ready to
  register activation codes, with preset defaults
  So I neither instantly die nor arm the bomb with unknown codes

@javascript
Scenario: Start up initially disarmed
  Given the bomb is not started
  When I start the bomb
  Then I see the bomb is disarmed
