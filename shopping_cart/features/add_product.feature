Feature: Adding product to shopping cart

Scenario Outline: I add a product into empty shopping cart
  Given I have empty shopping cart
  When I add an "<product>" to shopping cart
  Then I should see  "<qty>"" and "<subtotal>"
  And "<total>" and "<msg>"

@happy
 Examples:
    | product     | qty | subtotal | total | msg
    | water colors|   1 |    10.00 | 10.00 | 1 item is in cart
    | Paint Brush |   1 |    2.00  | 2.00  | 1 item is in cart

@bad
 Examples:
    | product     | qty | subtotal | total | msg                                         
    | oil colors  |   1 |   0.00   | 0.00  | Item is not available. Do you want to add it in wish list?


Scenario Outline: I add a product into non empty shopping cart
  Given I have empty shopping cart
  When I add an "<product>" to shopping cart
  Then I should see  "<qty>"" and "<subtotal>"
  And "<total>" and "<msg>"

  @happy
  Scenario: I add same sku product twice in shopping cart
    Given I have empty shopping cart
    When I add and "water colors" to shopping cart twice
    Then I should see only 1 "water colors" but the quantity is 2

  @happy
  Scenario: Adding two different products to shopping cart
    When I add 1 "card board" to shopping cart
    And I add 1 "pen" to shopping cart
    Then I should see 2 total products in the shopping cart
    And I should see a subtotal price and total for the products 

  @happy
  Scenario: Adding products as anonymous user and log in to my account
    Given I am not login in to my account 
    When  I add "card board" to shopping cart
    AND after adding product I login
    Then I should see the "card board" in my shopping cart

  @happy
  Scenario: Adding products as an existing user and log out
    Given I login as existing user
    When I add 1 "oil colors" to shopping cart
    And I log out
    Then I should empty shopping cart
    
  @happy
  Scenario: Adding products as an existing user and log out and login
    Given I login as existing user
    When I add 1 "paint brush" to shopping cart
    And I log out
    And I log in
    Then I should see 1 total products in the shopping cart
    And I should see "paint brush" with subtotal and total price in shopping cart
