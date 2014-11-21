Feature: Register custom activation/deactivation codes for the bomb
  I am Overlord
  A bomb that is insecure
  Is not that useful

  Background:
    Given I am on the home page

  @javascript
  Scenario: Register a custom activation code
    When I type "register activation death666"
    And I enter the query
    Then I should see "New activation code registered"

  @javascript
  Scenario: Register a custom deactivation code
    When I type "register deactivation kittens<3<3"
    And I enter the query
    Then I should see "New deactivation code registered"

