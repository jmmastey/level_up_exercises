Feature: Registration
  In order to log-in
  As a user
  I want to register
  So that I can have a personalized user experience

  Scenario: Registration
    Given I am not registered as a user
    When I am on the home page
    And I go to register through the registration link
    Then I should be directed to the registration page

  Scenario: Register as a user
    Given I am on the registration page
    And I am not a registered user
    When I fill out my details and submit
    Then I should be registered

  Scenario: Registering after adding items to cart
    Given I already have items in my shopping cart as a non-registered user
    When I register
    Then I should still have those items in my shopping cart
