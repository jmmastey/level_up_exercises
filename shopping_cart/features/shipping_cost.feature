feature: Shipping Estimation
  

  Scenario Outline: Shipping estimate calculator
    Given I fill out the shipping address and ready to checkout and the current subtotal is $12
    When I enter "<address>", "<city>", "<state>" and "<zipcode>"
    And I click "Estimate shipping" button
    Then I should see the message "<message>"
    And I should see shipping field has value "<shipping_cost>"
    And the total cost became "<total>"

@happy
  Examples:
    | address            | city      | state | zipcode | shipping_cost| total_cost | msg                      
    | 1600 S Indiana ave | Chicago   | IL    | 60616   | 6.00         |   18.00    | 
    | 186 Sunflower ln   | Bartlett  | IL    | 60103   | 4.00         |   16.00    | 

@sad
  Examples:
    | address          | city      | state | zipcode | shipping_cost| total_cost | msg                      
    | 2600 fremont blvd| fremont   | CA    | 94538   | 0.00         |   12.00    | Sorry we dont ship this item currently in CA
    | 122,rajeev gandhi| Ahmedabad | Guj   | 382007  | 0.00         |   12.00    | Sprry we dont ship this to outside of USA

@bad
  Examples:
    | address            | city      | state | zipcode | shipping_cost| total_cost | msg                      
    | 2951 s king drive  | Chicago   | IL    |  6011   | 0.00         |   12.00    | invalid zip code 
    

        
    