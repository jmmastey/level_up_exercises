Feature: Go to landing page
  In order to see the bomb
  As a visitor to the site
  I want to see the bomb interface

  Scenario: Bomb is not booted
    Given I am a website visitor
    When I go to the landing page
    Then the bomb should not be booted

  Scenario: Bomb is not activated
    Given I am a website visitor
    When I go to the landing page
    Then the bomb should not be activated
