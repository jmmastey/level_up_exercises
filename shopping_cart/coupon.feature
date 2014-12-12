Feature: Apply to coupond to shopping cart
    As a customer
    I want to apply the coupon to shopping cart
    So I can save some money
    
    Background:
        Given I have 2 "Category_a_item_1" in shopping cart and they cost $20
        And I have an "Category_b_item_1" in shopping cart and it cost $20
        And the sutotal for these items are $40

    Scenario Outline:
        When I appled "<coupon_code>"
        Then I should see the "<message>"
        And the Coupond Applied field should show "<coupon_code>"
        And the Money Saved field should have value "<total_saved>"
        And the new sutotal should be "<new_subtotal>"

    @happy
    Examples:
        | coupond_code              | total_saved       | new_subtotal  | message                                                  |
        | $5OFFENTIREORDER          | 5                 | 35            | The coupond code has applied to your shopping cart.      |
        | 5%OFFENTIREORDER          | 2                 | 38            | The coupond code has applied to your shopping cart.      |
        | 10%OFFONCATEGORYA         | 2                 | 38            | The coupond code has applied to your shopping cart.      |

    @bad
    Examples:
        | coupond_code              | total_saved       | new_subtotal  | message                                                  |
        |                           |                   | 40            | Please enter the valid coupond code.                     |
        | ""                        |                   | 40            | Please enter the valid coupond code.                     |
        | 10%OFFONCATEGORYA         | 2                 | 38            | The coupond code has applied to your shopping cart.      |
    
