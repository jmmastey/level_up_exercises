Feature: Shopping cart estimates
  As an online shopper
  I want to see shipping estimates
  Because I want to manage how much I spend

  Scenario: Load shipping address form
    Given I am logged in
    And I have a cart of 4 "computers"
    And I visit the cart page
    When I click on "See shipping estimate"
    Then I see the shipping address form

  Scenario: Load shipping address form
    Given I am not logged in
    And I have a cart of 4 "computers"
    And I visit the cart page
    When I click on "See shipping estimate"
    Then I see the shipping address form

  Scenario: Fill in shipping address form
    Given I am logged in
    And I have a cart of 4 "computers"
    And I visit the shipping estimate page
    When I fill in my address
    Then I see my estimated order total

  Scenario: Partially fill in shipping address form
    Given I am logged in
    And I have a cart of 4 "computers"
    And I visit the shipping estimate page
    When I fill in only my street address
    Then I see an error message

  Scenario: Using bogus address
    Given I am logged in
    And I have a cart of 4 "computers"
    And I visit the shipping estimate page
    When I fill in a bogus address
    Then I see an error message
