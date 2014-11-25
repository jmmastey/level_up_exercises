Feature: Remove items from the cart
  As a shopper
  In order to manage the cart
  I want to remove items from the cart

  @happy
  Scenario: Removes the only item
    Given I have 3 units of Item A in the cart
    When I remove Item A from the cart
    Then I should see a empty cart

  @happy
  Scenario: Remove one of the item
    Given I have 3 units of Item A in the cart
      And I have 4 units of Item B in the cart
    When I remove Item A from the cart
    Then I see 4 units of Item B in the cart
      But I do not see Item A in the cart

  @bad
  Scenario: Somehow try to remove an item not in the cart
    Given I have 3 units of Item A in the cart
    When I somehow remove Item B from the cart
    Then I should see a invalid request error
      And I still see 3 units of Item A in the cart
