Feature: Update Cart

  Scenario: I want to change the quantiy of an item
    Given I am signed in
      And I have items in my cart
      And I am on the shopping cart page
    Then I should on the shopping cart page
      And I should see the items I added
    When I change the quantity of "dog food" to 1 from 2
      And click on submit
    Then I should see the item dog food has quanity of 1

  Scenario: I want to remove an item
    Given I am signed in
      And I have items in my cart
      And I am on the shopping cart page
    Then I should on the shopping cart page
      And I should see the items I added
    When I delete item dog food
      And click on submit
    Then I should not see dog food on the item list

  Scenario: I want to move an item to wishlist
    Given I am signed in
      And I have items in my cart
      And I am on the shopping cart page
    Then I should on the shopping cart page
      And I should see the items I added
    When I wishlist item dog food
      And click on submit
    Then I should not see dog food on the item list
      And I should see my wishlist count increase
