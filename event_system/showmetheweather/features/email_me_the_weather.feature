Feature: email me the weather

  As a user
  I would like to have the weather emailed to me
  So that I do not have to visit the site each day

  Scenario: sign up
    Given I am not signed in 
    When I sign up 
    Then I see that I am signed in

  Scenario: update profile
    Given I am signed in
    When I update my profile
    Then my profile is updated

  Scenario: email sent
    Given I have a user account
    When the daily email forecast is sent to me
    Then it contains the weather forecast for the zip code that I configured
