Feature: Register Numeric Activation Codes
  As an evil super villian
  I want to enter configured activation codes required to arm and disarm the bomb
  So that I am the only one who can arm and disarm it

@javascript
Scenario: Visit bomb controls when no activation codes are registered
  Given the bomb has no activation codes registered
  When I view the bomb controls
  Then I see the activation code registration controls
  Then I see a field to register an arming code
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
