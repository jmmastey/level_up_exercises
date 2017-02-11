Feature: Error page
  As a Vault Boy
  When I go to a page that does not exist
  I will get a 404 page

  Scenario: Get a 404 page
    When I go to a page that does not exist
    Then I will get a 404 page
