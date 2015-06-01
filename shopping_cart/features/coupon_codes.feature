Feature: Coupon Codes

Scenario: Apply valid coupon/discount code to Cart
  Given I am a User
    And I have 2 Widgets in my Cart
  When I view the Cart page
    And I enter "15OFF" in the "Coupon Code" field
  Then a $3.00 discount is applied to my subtotal
    And my subtotal should be $17.00
    And my total should be $22.00

Scenario: Apply invalid coupon/discount code to Cart
  Given I am a User
    And I have 2 Widgets in my Cart
  When I view the Cart page
    And I enter "dfsdfs" in the "Coupon Code" field
  Then I see an "Invalid Coupon Code" error

Scenario: Apply expired coupon/discount code to Cart
  Given I am a User
    And I have 2 Widgets in my Cart
  When I view the Cart page
    And I enter "AUGUSTSPECIAL" in the "Coupon Code" field
  Then I see an "Expired Coupon Code" error

Scenario: Apply an Item-specific coupon/discount code to a Cart where the Item doesn't exist
  Given I am a User
    And I have 2 Widgets in my Cart
  When I view the Cart page
    And I enter "LAWN15" in the "Coupon Code" field
  Then I see an "Invalid Coupon Code" error
