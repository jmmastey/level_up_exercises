Feature: Get restaurant recommendation
  As a user
  I want to get a restaurant recommendation
  So I can stuff my face

  Scenario: Save invalid minimum rating search setting
    Given I am on the user account page
    When I enter an invalid minimum rating value 
    And I save my settings
    Then I should see an error message
  
  Scenario: Save invalid repeat interval search setting
    Given I am on the user account page
    When I enter an invalid repeat interval value 
    And I save my settings
    Then I should see an error message

  Scenario: Save valid minimum rating search setting
    Given I am on the user account page
    When I enter a valid minimum rating value 
    And I save my settings
    Then I should see a success message
  
  Scenario: Save valid repeat interval search setting
    Given I am on the user account page
    When I enter a valid repeat interval value 
    And I save my settings
    Then I should see a success message

  Scenario: Get a restaurant recommendation
    Given I am on the user account page
    When I click the Get Recommendation button
    Then I should see a restaurant entry
    And I should see an "I'm going" button

  Scenario: No recommendations found
    Given I am on the user account page
    And the search settings do not match any venues
    When I click the Get Recommendation button
    Then I should see a frowny face
    And I should see an explanation message 
