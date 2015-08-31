Feature: User Login
  In order to pass information from session to session
  As a shopper
  I should be able to have my cart remembered before and after login

  Background:
    Given I have 2 items in the cart
    And I am not logged in

  Scenario: Logging in
    When I log in with valid user data
    Then I should see 2 items in the cart

  Scenario: Logging in with invalid user data
    When I log in with invalid user data
    Then I should see an error message "invalid username or password"

  Scenario: Deleting items before the user logs in
    When I delete 2 items from my cart
    And I log in
    Then I should have no items in my cart

  Scenario: Adding Items before the user logs in
    When I add 2 items to my cart
    And I log in
    Then I should have 4 items in my cart
