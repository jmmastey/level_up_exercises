Feature: Member account login
  In order to take advantage of features and promotions
  As a returning customer
  I want to log into my member account

  Scenario: The cart still contains my unpurchased items from my last visit
    Given an account cart with 1 item with SKU 5 with quantity 3
    And a cart with 1 item with SKU 9 with quantity 2
    When I log in
    Then there is 1 item with SKU 5 with quantity 3

  Scenario: The cart still contains items I added anonymously
    Given an account cart with 1 item with SKU 5 with quantity 3
    And a cart with 1 item with SKU 9 with quantity 2
    When I log in
    Then there is 1 item with SKU 9 with quantity 2

  Scenario: The cart contains both copies of items I added in both contexts
    Given an account cart with 1 item with SKU 5
    And a cart with 1 item with SKU 5
    When I log in
    Then there are 2 items with SKU 5

  Scenario: I can change item quantities from my last visit
    Given an account cart with 1 item with SKU 5 with quantity 3
    When I log in
    And I set the quantity to 2
    Then there is 1 item with SKU 5 with quantity 2

  Scenario: I can change item quantities that I added anonymously
    Given a cart with 1 item with SKU 5 with quantity 3
    When I log in
    And I set the quantity to 2
    Then there is 1 item with SKU 5 with quantity 2

  Scenario: I can remove items from my last visit
    Given an account cart with 1 item with SKU 5
    When I log in
    And I remove 1 item with SKU 5
    Then there are 0 items with SKU 5

  Scenario: I can remove items that I added anonymously
    Given a cart with 1 item with SKU 5
    When I log in
    And I remove 1 item with SKU 5
    Then there are 0 items with SKU 5

  # Cucumber is not the right tool for this test
  Scenario: Logging in takes less than 2 seconds at least 95% of the time

  # Cucumber is not the right tool for this test
  Scenario: My credentials are handled securely

  Scenario: I try to log in but it fails
    Given a cart with 1 item with SKU 5
    When I fail to log in
    Then there is 1 item with SKU 5
