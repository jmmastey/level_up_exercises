Feature: Shipping

Scenario Outline: Shipping estimate
Given I fill out the shipping address and ready to checkout
When I enter <address>, <city>, <state> and <zip>
And I click "Estimate shipping" button
Then I see the message <message>
And I see shipping field has value <shipping_cost>
And the total cost became <total>

@happy
Examples:
| address               | city        | state | zip     | shipping_cost | total       | message |
| 1106 N Plum Grove Rd  | Schaumburg  | IL    | 60173   | 10.00         |   810.00    | Your package will be shipped in 3 days |
| 200 W jackson Blvd    | Chicago     | IL    | 60606   | 5.00          |   305.00    | Your package will be shipped in 2 days |

@sad
Examples:
| address               | city        | state | zip     | shipping_cost | total       | message |
| 14612 NE 36 ST        | Bellevue    | WA    | 98007   | 0.00          |   800.00    | Sorry we dont ship this item currently in WA |
| 559 Kha 42 Srinagar   | Lucknow     | UP    | 382007  | 0.00          |   300.00    | Sorry we dont ship this to outside of USA    |

@bad
Examples:
| address               | city        | state | zip     | shipping_cost| total        | message |
| 200 W jackson Blvd    | Chicago     | IL    |  588888 | 0.00         |   800.00     | invalid zip code  |

@happy
  Scenario: I entered correct shipping address
  When I enter "1106 N Plum Grove Rd", "Schaumburg", "IL" and "60173"
  And I click "Estimate shipping" button
  Then I see message "Your package will be shipped in 3 days"
  And I see shipping field has value "10"
  And the total cost became "810"