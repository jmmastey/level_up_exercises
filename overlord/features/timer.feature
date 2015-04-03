@javascript
Feature: Timer
    Scenario: Display timer on deactivate page
        Given Bomb is configured with default codes
        And Bomb is active
        When 5 seconds timer goes off
        Then He should see explode page

