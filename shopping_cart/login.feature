Feature: Support log-in for anonymous customers
  As a customer
  I want to be able to log in
  In order to complete my order

  @Happy
  Scenario: Cart items should persist after login
    Given I have not logged in
    And I have 5 items in my cart
    When I log in to an account with 0 items in it's cart
    Then I have 5 items in my cart

  @Happy
  Scenario: Cart items should merge after login
    Given I have not logged in
    And I have 5 items in my cart
    When I log in to an account with 5 items in it's cart
    Then I have 10 items in my cart

  @Happy
  Scenario: Log in without any items should give an empty cart
    Given I have not logged in
    And I have 0 items in my cart
    When I log in to an account with 0 items in it's cart
    Then I have 0 items in my cart

  @Sad
  Scenario: Incorrect login should not delete cart
    Given I have not logged in
    And I have 5 items in my cart
    When I incorrectly log in to an account
    Then I see an error message
    And I have items in my cart
