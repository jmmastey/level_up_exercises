Feature: Default activation codes
  As a lazy and absent-minded supervillian
  I want the bomb to start up with default activation codes
  So I don't have to think up and remember new ones nor initially key them in

Scenario: Default arming code is 1234
  Given a new bomb session
  When view the bomb controls
  Then I see the arming code 1234

Scenario: Default disarming code is 0000
  Given a new bomb session
  When I view the bomb controls
  Then I see the disarming code 0000
