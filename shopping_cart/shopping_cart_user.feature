Feature: User Login
  In order to pass information from session to session
  As a shopper
  I should be able to have my cart remembered before and after login

  Background:
    Given I am viewing "checkout"
    And there exists "user"
    And the "user" is not logged in
    And the "user" currently has "3 socks, 2 shoes"

  Scenario: Logging In
    Given the "user" logs in
    And the "user" currently has "3 socks, 2 shoes"

  Scenario: Deleting items
    And the "user" delete "socks" 3
    When the "user" logs in
    Then the "user" currently has "2 shoes"

  Scenario: Adding Items
    Given the "user" add "socks" 2
    When the "user" logs in
    Then the "user" currently has "5 socks, 2 shoes"

  Scenario: User logs out and add items
    Given the "user" logs in
    When the "user" logs out
    Then the "user" currently has "no items"
    And the "user" add "socks" 2
    Then the "user" currently has "2 socks"
