Feature: Bomb Creation
  In order to use this application at all
  As a bomber
  I want to be able to create a bomb

  @javascript
  Scenario: No bomb present
    Given there is no bomb present
    Then I should see a link to create a new bomb

  @javascript
  Scenario: Interacting with an exploded bomb
    Given I am viewing an exploded bomb
    Then the security code form should be gone
      And I should see a link to create a new bomb
