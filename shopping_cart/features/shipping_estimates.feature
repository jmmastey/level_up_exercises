Feature: Shipping Estimates

Scenario: Get estimated shipping costs via ZIP code
  Given I am a User
    And I have 2 Widgets in my Cart
  When I view the Cart page
    And I enter "60647" in the "ZIP Code" field
  Then I see shipping estimates for the "60647" ZIP code

Scenario: Failed attempt to get estimated shipping costs
  Given I am a User
    And I have 2 Widgets in my Cart
  When I view the Cart page
    And I enter "dfsdf" in the "ZIP Code" field
  Then I should see an "Invalid ZIP Code" error message
