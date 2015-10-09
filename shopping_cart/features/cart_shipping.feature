@Happy
Scenario: Entering an address to get shipping estimates
  Given that I am on the cart page
  When I select my country from the list
  And I enter my zip code in the field
  And I click the button 'Calculate Estimate'
  Then the proper estimate should be calculated
  And added to the orders totals

@Sad
Scenario: Entering a wrong address to get shipping estimates
  Given that I am on the cart page
  When I select my country from the list
  And I enter my zip code in the field
  And I click the button 'Calculate Estimate'
  When the zip is unknown or does not exist.
  Then an informative error is displayed.

@Bad
Scenario: Entering garbage to get shipping estimates
  Given that I am on the cart page
  When I select my country from the list
  And I enter a garbage zip code in the field
  And I click the button 'Calculate Estimate'
  Then an informative error is displayed.
