Feature: Logging in
  In order to purchase items online
  As an online shopper
  I want to be able login with item already in cart

  Background: My cart already contains some items
    Given my cart contains 3 pairs of socks
    And my cart contains 1 pair of jeans
    And I'm on the shopping cart page

  Scenario: Logging in with previous items in shopping cart
    Given my logged in cart contains a blouse
    When I login
    Then my cart should contain 1 blouse
    And my cart should contain 3 pairs of socks
    And my cart should contain 1 pair of jeans

  Scenario: Logging in with same items in shopping cart
    Given my logged in cart contains 1 pair of the same socks
    When I login
    Then my cart should contain 3 pairs of socks
    And my cart should contain 1 pair of jeans