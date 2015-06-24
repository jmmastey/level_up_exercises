Feature: Get shipping estimates

  As a shopper, I want to be able to enter my address to find out my shipping cost
  so I can know the total cost of my purchase

  Scenario:enter shipping address
   Given I am on the checkout page
   When I enter my shipping address
   And click the update address button
   Then I should see shipping estimates based off of time to deliver

  Scenario: enter invalid shipping address
   Given I am on the checkout page
   When I enter an address that does not exist
   And click the update address button
   Then I should see an error message that says unable to verify shipping address

  Scenario: leave out required fields in shipping address
   Given I am on the checkout page
   When I enter an address without adding city and state
   And click the update address button
   Then I should see an error message asking to fill in required fields

  Scenario: select the same address as in credit card information
   Given I am on the checkout page
   When I select the checkbox that says use the same address as listed for the credit card
   Then the shipping address fields are automatically populated correctly

  Scenario Outline: enter invalid characters
    Given I am on the checkout page
    When I enter <invalid > characters in the <field> field in my address
    Then I should see an error message

    Examples:
      | invalid | field      |
      |  &*^%(  | first name |
      |  #@(*&( | address    |
      |  $#!@& }| city       |