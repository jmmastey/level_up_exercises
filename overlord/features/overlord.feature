

Feature: Start bomb
  As a villain
  I want to boot the bomb
  So that I can activate it

Scenario: Valid Activation
  Given I visit the overlord home page
  When I type in the right activation code
  And I click activate
  Then I should see the bomb status as active

Scenario: Valid Deactivation
  Given I am on the activate page
  When I type in the right deactivation code
  And I click deactivate
  Then I should see the bomb status as inactive

Scenario: Invalid Activation
  Given I visit the overlord home page
  When I type in the wrong activation code
  And I click activate
  Then I should see the bomb status as inactive

Scenario: Invalid Deactivation
  Given I am on the activate page
  When I type in the wrong deactivation code
  And I click deactivate
  Then I should see the bomb status as active

Scenario: Second Deactivation Attempt
  Given I am on the deactivate page
  When I type in the wrong deactivation code
  And I click deactivate
  Then I should see the bomb status as active

Scenario: Third Deactivation Attempt
  Given I am on the deactivate page after second attempt
  When I type in the wrong deactivation code
  And I click deactivate
  Then I should see the bomb status as exploded

Scenario: Non-Numeric Deactivation 
  Given I am on the activate page
  And the password is 0000
  When I type in password
  And I press deactivate
  Then the bomb should be active

Scenario: Code is More Than Four Characters
  Given I am on the deactivate page
  And the password is 0000
  When I type in 0000000
  And I press deactivate
  Then the bomb should be active
