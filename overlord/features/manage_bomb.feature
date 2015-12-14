Feature: A Working Bomb
  As a super villain
  I want a working bomb
  So that I can cause terror

  @javascript
  Scenario: boot bomb
    Given I am on the homepage
    When I submit an activation and deactivation code
    Then the bomb should be booted

  @javascript
  Scenario: non-numeric codes
    Given I am on the homepage
    When I submit non-numeric activation or deactivation codes
    Then the bomb should not be booted

  @javascript
  Scenario: activate bomb
    Given I am on the homepage
    When I activate the bomb
    Then the bomb should be activated

  @javascript
  Scenario: deactivate bomb
    Given I am on the homepage
    And I activate the bomb
    When I enter the deactivation code
    Then the bomb should be deactivated

  @javascript
  Scenario: Failure to deactivate then the bomb should explode
    Given I am on the homepage
    And I activate the bomb
    When I fail to deactivate the bomb
    Then the bomb should explode
