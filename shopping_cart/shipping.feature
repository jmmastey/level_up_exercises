Feature: Receive shipping estimates based on address information
  As a customer
  I should be able to enter my address
  So that I can receive a shipping estimate

  @happy
  Scenario: I enter my address information
    Given I have "1" "Sample Item A" in my cart
    And the "shipping_total" field has value "0.00"
    When I enter "123 Main Street" in "address_1" field
    And I enter "Chicago, IL" in "address_2" field
    Then I should see "shipping_total" field has value greater than "0.00"

  @sad
  Scenario: I enter my address information
    Given I have "1" "Sample Item A" in my cart
    And the "shipping_total" field has value "0.00"
    When I enter "" in "address_1" field
    And I enter "" in "address_2" field
    Then I should see "shipping_total" field has value "0.00"