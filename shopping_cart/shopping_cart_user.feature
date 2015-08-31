Feature: User Login
  In order to pass information from session to session
  As a shopper
  I should be able to have my cart remembered before and after login

  Background:
    And there exists "user"
    And the "user" is not logged in
    And the "user" currently has "3 socks, 2 shoes"

  Scenario: Logging In
    When the "user" logs in
    Then the "user" currently has "3 socks, 2 shoes"

  Scenario: Deleting items before the user logs in
    When the "user" delete "3 socks"
    And the "user" logs in
    Then the "user" should have "2 shoes"

  Scenario: Adding Items before the user logs in
    Given the "user" adds "2 socks"
    When the "user" logs in
    Then the "user" should have "5 socks, 2 shoes"

  Scenario: User logs out and add items
    Given the "user" is logged in
    When the "user" logs out
    Then the "user" should see "no items"
    When the "user" adds "2 socks"
    Then the "user" should have "2 socks"
