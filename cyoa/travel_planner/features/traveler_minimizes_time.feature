Feature: traveler minimizes travel time

  As a traveler going to a meeting
  I want to find the best flight options
  So that I can minimize my travel time

  Scenario: traveler starts the application
    Given I am not yet using the application
    When I go to the home page
    Then I should see "Please enter your meeting details"

  Scenario: traveler finds flights by airport code
    Given that I entered my travel needs
    When I click "Find shortest trip"
    Then I should see the shortest trip
    And I should see trip requirements
    And I should see alternate flight options

  Scenario: traveler selects default flights
    Given that I am viewing the shortest flights
    When I click "Go with these"
    Then I should see a trip summary

