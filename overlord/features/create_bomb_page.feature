Feature: Overlord Create-Bomb Page
  In order to test the Overlord create-bomb page
  As a developer who wrote Overlord
  I want to visit the page and make sure the form works

  Scenario: I visit the main page
    Given I visit the main page
    Then I should see the Create Bomb page

  Scenario: I visit the main page and click create-bomb
    Given I create a bomb from the main page
    Then I should see the bomb status page
