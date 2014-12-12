Feature: calculate the shipping cost base on the shipping address
    As a customer
    I want to fill out my shipping address
    So I can konw the shipping cost before I place an order
       
    Scenario: I fill out the shipping address
        Given I am ready to checkout and the current subtotal is $20
        When I enter "<address>", "<city>", "<state>" and "<zipcode>"
        And I click "Estimate shipping" button
        Then I should see the message "<message>"
        And I should see shipping field has value "<shipping_cost>"
        And the total cost became "<total_cost>"

    @happy
    Examples:
        | address                       | city           | state | zipcode   | shipping_cost   | total_cost      | message                                                  |
        | 200 W Jackson Blve            | Chicago        | IL    | 60606     | 2               | 22              |                                                          |
        | 1600 Amphitheatre Parkway     | Mountain View  | CA    | 94043     | 10              | 30              |                                                          | 
    
    @sad
    Examples:
        | address                       | city           | state | zipcode   | shipping_cost   | total_cost      | message                                                  |
        | 4334 Rice St.                 | Lihue          | Hi    | 96766     | 0               | 20              | We only ship to continental address.                     |
        | 101 Dunkel St.                | Fairbanks      | AK    | 99701     | 0               | 20              | We only ship to continental address.                     |
        
    @bad
    Examples:
        | address                       | city           | state | zipcode   | shipping_cost   | total_cost      | message                                                  |
        | 200 W Jackson Blve            | Chicago        | IL    | 606       | 0               | 20              | Invalid zipcode. The shipping cost is based on zipcode.  |
