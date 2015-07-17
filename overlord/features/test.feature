Feature: Go to landing page
  In order to see my welcome message
  As a visitor to the site
  I want to see the words "Hello world!"

  Scenario: Go to landing page
    Given I am a website visitor
    When I go to the landing page
    Then I should see "Hello world!"
