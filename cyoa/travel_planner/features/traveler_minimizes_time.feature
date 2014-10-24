Feature: traveler minimizes travel time

  As a traveler going to a meeting
  I want to find the best flight options
  So that I can minimize my travel time

  Scenario: traveler finds flights by airport code
    Given that I entered my travel needs
    When I click find shortest travel time
    Then I should see flight options
