Feature: Get restaurant recommendation
  As a user
  I want to get a restaurant recommendation
  So I can stuff my face

  Scenario: Save invalid minimum rating search setting
    Given I am logged into my account
    When I enter an invalid minimum rating value 
    And I save my settings
    Then I should see an error alert box 
  
  Scenario: Save invalid repeat interval search setting
    Given I am logged into my account
    When I enter an invalid repeat interval value 
    And I save my settings
    Then I should see an error alert box 

  Scenario: Save valid minimum rating search setting
    Given I am logged into my account
    When I enter a valid minimum rating value 
    And I save my settings
    Then I should see a success alert box 
  
  Scenario: Save valid repeat interval search setting
    Given I am logged into my account
    When I enter a valid repeat interval value 
    And I save my settings
    Then I should see a success alert box 

  Scenario: Save new search radius setting
    Given I am logged into my account
    When I change the search radius selector
    And I save my settings
    Then I should see a success alert box 

  Scenario: Get a restaurant recommendation
    Given I am logged into my account
    And a venue exists
    When I click the Get Recommendation button
    Then I should see a restaurant entry
    And I should see a "Sold! I'm going" button

  Scenario: No recommendations found
    Given I am logged into my account
    And the search settings do not match any venues
    When I click the Get Recommendation button
    Then I should see a frowny face
    And I should see an explanation message 
