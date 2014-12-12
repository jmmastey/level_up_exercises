Feature: Navigate to the item page from shopping cart
    As a customer
    I want to go back to item page from the shopping cart
    So I can view the item detail again
    
    Scenario: I go back to item page from shppoing cart
        Given I have "item 1" on the shopping cart
        When I click "item 1"
        Then I should see the "item 1 info" 
