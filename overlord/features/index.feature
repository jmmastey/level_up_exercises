Feature: view pages
  Scenario: Homepage
    Given I am viewing '/'
    Then I should see 'Welcome'