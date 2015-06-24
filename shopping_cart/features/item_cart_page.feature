Feature: navigating to item pages from the individual cart item lines

  As a shopper I want to be able to go to the item pages from my shopping cart
  so I can get more details on the product I am buying

  Scenario: navigate to the item page by clicking the title  of the item
    Given I am on the shopping cart page
    When I click on the title of my stereo
    Then I should be taken to the item page for that stereo

  Scenario: navigate to the item page by clicking the picture  of the item
    Given I am on the shopping cart page
    When I click on the picture of my xbox
    Then I should be taken to the item page for that xbox


   Scenario: navigate back to the shopping cart page
    Given I am on the item page
    When I click on the shopping cart link
    Then I am taken back to the shopping cart

   Scenario: verifying items still exist in the shopping cart page
     Given I am on the item page
     When I navigate back to the shopping cart link
     Then I see all the items that were there previously

   Scenario: unable to navigate to the item page
     Given I am on the shopping cart page
     When I do not click on a picture or title of an item
     Then I should not be taken to the item page for that item





