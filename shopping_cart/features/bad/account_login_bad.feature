#encoding: utf-8

Feature: Bad Logging In
  In order to register
  As an online shopper
  I should log in
  And begin shopping

  Scenario: I log in while in a guest session
    Given I have an open session with items in my cart
    And I am not logged in
    And I have an account on the shopping site
    When I log in
    Then my items will still be in my shopping cart

  Scenario: I log out while in a registered user session
    Given I have an open session with items in my cart
    And I am logged in
    When I log out
    Then my my cart should be empty

  Scenario: Merging carts
    Given I have two open sessions with different items in each cart
    And I am not logged in on either session
    And I have an account on the shopping site
    When I log into both sessions
    Then my items from both sessions will merge into my login cart


