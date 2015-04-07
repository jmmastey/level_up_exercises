Feature: chart switching controls
  In order to view a different chart
  As a curious whatpulser
  I want to be able to click one of the buttons to view a different chart

  Background:
    Given I am on the page
    And I click go

  @javascript
  Scenario: viewing clicks chart
    When I click clicks
    Then I should see the clicks chart

  @javascript
  Scenario: viewing download chart
    When I click download
    Then I should see the download chart

  @javascript
  Scenario: viewing upload chart
    When I click upload
    Then I should see the upload chart

  @javascript
  Scenario: viewing uptime chart
    When I click uptime
    Then I should see the uptime chart

  @javascript
  Scenario: viewing the keys chart
    Given I click clicks
    When I click keys
    Then I should see the keys chart
