Feature: Store a blacklist
  As a user
  I want to blacklist some venues
  So they will not be recommended

  Scenario: Add venue to blacklist
    Given I am logged into my account
    And a venue exists
    When I visit the venues page
    And I click the blacklist checkbox
    Then the venue should be stored in the blacklist

  Scenario: Remove venue from blacklist
    Given I am logged into my account
    And I have blacklisted a venue
    When I clear the blacklist checkbox
    Then the venue should be removed from the blacklist
