Feature Add an item not in stock
  As a customer
  I should not be able to add invalid items to my cart
  So that I don't attempt to buy something that isn't available

  Background:
    Given I have an empty cart

  @Sad
  Scenario: I add an item to the cart that is not in stock, it shows an error
    And I am on the page of an item that it not in stock
    When I try to add the item to my cart
    Then I should see an error message

  @Sad
  Scenario: When I add an item to the cart that is not in stock, it should not add to the cart
    And I am on the page of an item that is not in stock
    When I try to add the item to my cart
    Then I should have 0 items in my cart

  @Sad
  Scenario: When I add an item to the cart that is not yet for sale (i.e. not released yet), it should show an error
    And I am on the page of an unreleased item
    When I try to add the item to my cart
    Then I should see an error message

  @Sad
  Scenario: When I add an item to the cart that is not yet for sale (i.e. not released yet), it shouldn't add to the cart
    And I am on the page of an unreleased item
    When I try to add the item to my cart
    Then I should have 0 items in my cart

  @Bad
  Scenario: When I add a garbage item to the cart (by messing with the URL or otherwise), it should show an error
    When I try to add an invalid item to the cart
    Then I should see an error message

  @Bad
  Scenario: When I try to add a garbage item to the cart (by messing with the URL or otherwise), it should not add to the cart
    When I try to add an invalid item to the cart
    Then I should have 0 items in my cart
