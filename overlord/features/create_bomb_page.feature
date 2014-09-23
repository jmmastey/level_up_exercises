Feature: Overlord Create-Bomb Page
  In order to test the Overlord create-bomb page
  As a developer who wrote Overlord
  I want to visit the page and make sure the form works

  Scenario: I visit the main page
    Given I visit the main page
    Then I should see content

  Scenario: I visit the main page and click create-bomb
    Given I visit the main page
    When I click the Create button
    Then I should see the bomb status page
