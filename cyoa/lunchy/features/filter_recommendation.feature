Feature: Filter restaurant recommendation
  As a user
  I want to filter the restaurant recommendation
  So I can get customized recommendations

  Scenario: Filter recommendations by minimum rating - no match
    Given I am logged into my account
    And a venue exists with a rating of 8.0
    When I get a recommendation with my minimum rating set to 8.1
    Then I should see a frowny face
    And I should see an explanation message

  Scenario: Filter recommendations by minimum rating - match
    Given I am logged into my account
    And a venue exists with a rating of 8.0
    When I get a recommendation with my minimum rating set to 7.9
    Then I should see a restaurant entry

  Scenario: Filter recommendations by repeat interval - no match
    Given I am logged into my account
    And a venue exists
    And I added it to my history yesterday 
    When I get a recommendation with my repeat interval set to 2
    Then I should see a frowny face
    And I should see an explanation message

  Scenario: Filter recommendations by repeat interval - match
    Given I am logged into my account
    And a venue exists
    And I added it to my history yesterday 
    When I get a recommendation with my repeat interval set to 1
    Then I should see a restaurant entry

  Scenario: Filter recommendations by blacklist - venue blacklisted 
    Given I am logged into my account
    And a venue exists
    And I added it to my blacklist
    When I click the Get Recommendation button
    Then I should see a frowny face
    And I should see an explanation message
