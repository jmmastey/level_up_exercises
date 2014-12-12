Feature: Update the shopping cart
    As a customer
    I want to update the items quantity
    So I can purchase the desire quantity of product

    Scenario Outline: I update an items quantity
        Given I have 2 "item 1" in shopping cart and the subtotal is $20
        When I add an "<item>" to the shopping cart
        And I change quantity of "<item>" to "<new_quantity>"
        Then I sould see "<message>"
        Then the total item should be "<total_items>"
        And the subtotal should be "<subtotal>"
        
    @happy
    Examples:
        | item    | new_quantity     | total_items  | subtotal  | message                |
        | item 1  | 1                | 2            | 20        |                        |
        
    @sad
    Examples:
        | item    | new_quantity     | total_items  | subtotal  | message                                                                |
        | item 1  | 0                | 0            | 0         | If you change the quanity to 0, the item will be removed from the cart |

    @bad
    Examples:
        | item    | new_quantity     | total_items  | subtotal  | message                                                |
        | item    | -1               | 3            | 30        | Invalid value ! The quantity value can not be < 0      |
        | item    | a                | 3            | 30        | Invalid value ! The quantity value only allow numeric  |

