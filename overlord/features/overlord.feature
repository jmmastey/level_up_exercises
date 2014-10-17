Feature: Start bomb
  As a villain
  I want to boot the bomb
  So that I can activate it

Scenario: Valid 
  Given I visit the overlord page
  When I type in the right activation code
  And I click activate
  Then I should see the bomb status as active
