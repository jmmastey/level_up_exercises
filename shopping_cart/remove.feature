Feature: Remove the item from the shopping cart
    As a customer 
    I want to remove the item from shopping cart before I checkout
    So I dont' need to purchase unwanted item

    Background:
        Given I add "item 1" to cart
        And I add "item 2" to cart

    Scenario: I remove item from the shopping cart
        When I remove "item 1"
        Then I should not see the "item 1" on the shopping cart
        And the total item field change to 1
    
    Scenario: I remove item from the cart and add the same item back to shopping cart
        When I remove "item 1"
        And I add "item 1" to shopping cart
        Then I should see "item 1" on the shopping cart
        And the quantity of "item 1" is 1
        And the total item field change to 2
