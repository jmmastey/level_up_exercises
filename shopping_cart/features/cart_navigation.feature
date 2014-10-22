Feature: Shopping cart navigation
  In order to view and edit products in my shopping cart
  As a consumer
  I need to be able to go directly to product page from shopping cart

  Background:
    Given shopping cart has 1 "Product 1"
    And shopping cart has 2 "Product 2"
    And shopping cart has 1 "Product 1"
    And I am on the shopping cart page

  @happy_path
  Scenario: Click on a product link
    When I click on "Product 1"
    Then I should see "Product 1" page
    And I should not see "Product 2" page
    And I should not see "Product 3" page

  @sad_path
  Scenario: Click on a product link
    When I click on "Product 2"
    Then I should see an error page
    And I should see a link to return to previous page

  @bad_path
  Scenario: Click on product link
    When I click on "Product 3"
    Then I see the google home page
    And I am no longer on my site