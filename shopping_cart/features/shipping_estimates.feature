Feature: Shipping Estimates

Scenario: Get estimated shipping costs via ZIP code
  Given I am a User
    And I have 1 or more Items in my Cart
    And I am viewing the Cart page
  When I enter a valid 5-digit ZIP code
    Then I should see estimated shipping costs for all available shipping options

Scenario: Failed attempt to get estimated shipping costs
  Given I am a User
    And I have 1 or more Items in my Cart
    And I am viewing the Cart page
  When I enter anything except a valid 5-digit ZIP code
    Then I should see error messaging telling me that I must enter a valid 5-digit ZIP code
