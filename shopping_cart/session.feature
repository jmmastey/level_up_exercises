Feature: Session Management
  As a user
  I want the system to track my cart when I am not logged in

  Scenario: Log in with existing products from anonymous session
    Given I am not logged in
    And I add products to my cart
    And I log in
    And I add products to my cart
    When I view my cart
    Then I should see all products I added to my cart

  Scenario: Log in without existing products from anonymous session
    Given I am not logged in
    And my cart is empty
    And I log in
    When I view my cart
    Then I expect my cart to be empty

  Scenario: Log in with existing products from authenticated session
    Given I am logged in
    And I add products to my cart
    And I logout
    And I log in
    When I view my cart
    Then I should see all products I added to my cart