Feature: Allow user to maintain shopping cart after logging in (from anonymous user state)

  In order to create an order
  As the customer
  I fill my shopping cart and log in

  Scenario: Add item as anonymous user
    Given I am not logged in
    And I am on an item page
    When I click on the Add Item button
    Then I see the item was added to the shopping cart

  Scenario: Login and maintain items in shopping cart
    Given I am not logged in
    And I have 3 cats figurine items in my cart
    When I click the Login button
    And I log in
    Then I see my shopping cart contains 3 cat figurine items

  Scenario: Cart combines old and new items when I login
    Given I am not logged in
    And my anonymous user cart contains 3 cat figurines
    And my account cart contains 2 mouse figurines
    When I login
    Then I see my shopping cart now contains 3 cat figurines and 2 mouse figurines
