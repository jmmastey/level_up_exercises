@overlord

Feature: Shopping Cart
  A simple shopping cart that allows people to add a item to a cart
  and then on those items be able to add, remove or change quantities.

  The shopping cart should provide shipping estimates on items without
  forcing the user to checkout. Additionally, the user should be allowed
  to add unexpired coupons and have the new price reflected for the item
  once the coupons have been applied.

  The user's cart can have 2 states: a cart with items when the user is not
  logged in, and a cart from a previous session.

  Background:
    Given I visit the configuration page

  Scenario: User inserts letters for codes on config
    Given Configure bomb with codes '2a33' and 'ABBA'
    Then The bomb should not be configured



  Scenario: User creates a custom code to create a bomb
    Given Configure bomb with codes '6666' and '9999'
    When I activate the bomb with code '6666'
    Then I should see 'Activated'
      And I fill in '9999' to deactivate the bomb
    Then I should see 'Deactivated'
