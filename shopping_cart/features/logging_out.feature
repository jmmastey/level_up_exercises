Feature: Member account logout
  In order to maintain my privacy and account security
  As a customer
  I want to logout of my account when I'm done using it

  Scenario: I log out with no items in my cart
    Given I am logged in
    And an empty cart
    When I log out
    And I log in
    Then there are 0 items

  Scenario: I log out with an item in my cart
    Given I am logged in
    And a cart with 1 item with SKU 5 with quantity 3
    When I log out
    And I log in
    Then there is 1 item with SKU 5 with quantity 3
  
  # Cucumber is not the right tool for this test
  Scenario: Logging out takes less than 2 seconds at least 95% of the time
  
  # Cucumber is not the right tool for this test
  Scenario: My credentials are handled securely
