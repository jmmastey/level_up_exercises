Feature: Checkout

  Scenario: Checkout is successful
    Given I am signed in
      And The page is SSL Secured
      And I have items in my cart
      And I am on the shopping cart page
    Then I should on the shopping cart page
      And I should see the items I added
    When I click on checkout
    Then I should be on the checkout page
      And I should see payment options field
    When I click on credit card
    Then I should see a form to entere my credit card information with valid info
    When I complete my credit card information
      And I click submit
    Then I should be directed to the confirmation page

  Scenario: Checkout was not successful
    Given I am signed in
      And The page is SSL Secured
      And I have items in my cart
      And I am on the shopping cart page
    Then I should on the shopping cart page
      And I should see the items I added
    When I click on checkout
    Then I should be on the checkout page
      And I should see payment options field
    When I click on credit card
    Then I should see a form to entere my credit card information
    When I complete my credit card information with invalid info
      And I click submit
    Then I should see a message stating my credit card is not valid
