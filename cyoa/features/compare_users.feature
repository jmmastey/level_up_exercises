Feature: compare users
  In order to view a comparison between two users
  As a curious whatpulser
  I want to be able to enter two users to see a comparison between two users

  Background:
    Given I am on the page

  @javascript
  Scenario: viewing the default comparison
    When I click go
    Then I should see a chart with data in it

  @javascript
  Scenario: viewing a custom comparison
    When I enter the first user name
    And I enter the second user name
    And I click go
    Then I should see a chart with data in it
