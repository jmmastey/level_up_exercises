Feature: Remove from cart
  In order to avoid buying items I don't want
  As a customer
  I want each item to have a "Remove" button to remove it from the cart

  Scenario: I remove the only item in the cart
    Given a cart with 1 item with SKU 5
    When I remove the item with SKU 5
    Then there are 0 items with SKU 5
    
  Scenario: I remove an item when there are other items also in the cart
    Given a cart with 1 item with SKU 5
    And 1 item with SKU 9
    When I remove the item with SKU 5
    Then there are 0 items with SKU 5
    And there is 1 item with SKU 9
    
  Scenario: I remove an item when there is a duplicate item also in the cart
    Given a cart with 2 items with SKU 5 with description "engraved Jack"
    When I remove 1 item with SKU 5 with description "engraved Jack"
    Then there is 1 item with SKU 5 with description "engraved Jack"
    
  Scenario: I remove an item when there are other items with the same SKU
    Given a cart with 1 item with SKU 5 with description "engraved Jack"
    And 1 item with SKU 5 with description "engraved Jill"
    When I remove 1 item with SKU 5 with description "engraved Jack"
    Then there are 0 items with SKU 5 with description "engraved Jack"
    And there is 1 item with SKU 5 with description "engraved Jill"
    
  Scenario: I remove an item whose quantity is greater than 1
    Given a cart with 1 item with SKU 5 with quantity 3
    When I remove the item with SKU 5
    Then there are 0 items with SKU 5
  
  # Cucumber is not the right tool for this test
  Scenario: Removing an item takes less than 1 second at least 95% of the time
  
  # Cucumber is not the right tool for this test
  Scenario: My credentials are handled securely
