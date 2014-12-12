Feature: Add the item to shopping cart
    As a customer
    I want to add items to shopping cart
    So I can make a purchase

    Scenario Outline: I add an item to the empty cart
        Given I have an empty shopping cart
        When I add an "<item>" to shopping cart
        Then I should see the "<message>"
        And I should see the "<total_items>" and "<subtotal>"

    @happy
    Examples:
        | item       | total_items  | subtotal  | message               |
        | item 1     | 1            | 10.50     | 1 item added to cart  |
    
    @sad
    Examples:
        | item       | total_items  | subtotal  | message                   |
        | item 1     | 0            | 0         | The item is not avaiable  |
    

    Scenario Outline: I add an item to non empty shopping cart
        Given the shopping cart has 1 itme and subtotal is 10.5
        When I add an "<item>" to shopping cart
        Then I should see the "<message>" 
        And I should see the "<total_items>" and "<subtotal>"
        
    @happy
    Examples:
        | item    | total_items  | subtotal  | message               |
        | item 1  | 2            | 21        | 1 item added to cart  |

    @sad
    Examples:
        | item    | total_items  | subtotal  | message                    |
        | item 1  | 1            | 10.5      | The item is not available  |


    Scenario: I add same SKU item twice
        Given I have empty shopping cart
        When I add and "item 1" to shopping cart twice
        Then I sould see only 1 "item 1" but the quantity is 2

    Scenario: I add an item to cart as anonymous and log in to my account
        Given I am not login to account
        When I add an "item 1" to shopping cart
        And I login as "User 1"
        Then I should see the "item 1"

    Scenario: I add an item to cart as anonymous adn login in then logout
        Given I am not login to account
        When I add an "item 1" to shopping cart
        And I login as "User 1"
        And I logout
        Then the shopping cart should be empty

    Scenario: I add an item to shopping cart with registered user then logout
        Given I login as "User 1"
        When I add an "item 1" to shopping cart
        And I logout
        Then the shopping cart should be empty

    Scenario: I have "item 1" in registered account and I add the same item with same SKU as anonymous
        Given I am no login to account
        When I add an "item 1" to shopping cart
        And I login as "User 1"
        Then the quantity of "item 1" should be 2
   
