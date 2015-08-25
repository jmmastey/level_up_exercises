Feature: Items in cart link back to item product pages
  In order to confirm that I've ordered the right items
  As a customer
  I want to click on an item in the shopping cart to return to its product page

  Scenario: I click an item
    Given a cart with 1 item with SKU 5
    When I click the item with SKU 5
    Then I go to the product page for SKU 5

  # Cucumber is not the right tool for this test
  Scenario: Loading a page takes less than 1 seconds at least 95% of the time

  # Cucumber is not the right tool for this test
  Scenario: My credentials are handled securely
