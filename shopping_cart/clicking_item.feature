Feature: Clicking an item leads to it's product page
  In order to buy necessary goods
  As a customer
  I should be able to click on items in the cart and see their page
  @Happy
  Scenario: When I click on a shopping cart item, it should redirect me to it's webpage
    Given I have items in my cart
    When I click on the first item
    Then I should be on the first item's page

  @Sad
  Scenario: When I try to click on an item that has been removed from the store, I should be taken back to the cart showing an error and that the item has deleted.
    Given I have an item in my cart that has since been removed from the store
    When I try to click the item page
    Then I should see an error that the item has been deleted

  @Sad
  Scenario: When I try to click on an item that has been removed from the store, it should be removed from the cart
    Given I have an item in my cart that has since been removed from the store
    When I try to click the item page
    Then I should not have that item in my cart