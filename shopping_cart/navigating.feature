Feature: Navigate to item pages
  As a customer
  I want to navigate back to item pages
  So that I can view the item information

  @happy
  Scenario: I navigate to an item page from the cart
    Given I have "1" "Sample Item A" in my cart
    When I click on "Sample Item A"
    Then I should see "Sample Item A Details"
