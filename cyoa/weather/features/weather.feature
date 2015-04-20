Feature:
  As a logged in user
  When I am on the weather app
  I should see the weeks weather

  Scenario: View the weather 
    Given I am logged in
    Then I should be able to see the weeks weather
