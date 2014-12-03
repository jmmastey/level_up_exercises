Feature: Remove items from the cart
  As a shopper
  In order to manage the cart
  I want to remove items from the cart

  @happy
  Scenario: Removes the only item
    Given I have 3 units of Item A in the cart
    When I remove Item A from the cart
    Then I see an empty cart

  @happy
  Scenario: Remove one of the item
    Given I have 3 units of Item A in the cart
      And I have 4 units of Item B in the cart
    When I remove Item A from the cart
    Then I see 4 units of Item B in the cart
      And I do not see Item A in the cart

  @bad
  Scenario: try to remove an item not in the cart
    Given I have 3 units of Item A in the cart
    When I remove Item B from the cart
    Then I see a invalid request error
      And I see 3 units of Item A in the cart
