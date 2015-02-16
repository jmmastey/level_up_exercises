Feature: Shipping Estimates

  Scenario: The address entered is valid
    Given I am signed in
      And I have items in my cart
      And I am on the shopping cart page
    Then I should on the shopping cart page
      And I should see the items I added
      And I should see a field for shipping estimate on each item
      And I should see a selection of addresses associated with my account
      And I should see a link to create a new address
    When I follow the link to create a new address
    Then I should be on the add a new address page
    When I complete the form with a valid address
    Then I should be on the checkout page
      And I should see shipping estimate cost on each item

  Scenario: The address entered is not valid
    Given I am signed in
      And I have items in my cart
      And I am on the shopping cart page
    Then I should on the shopping cart page
      And I should see the items I added
      And I should see a field for shipping estimate on each item
      And I should see a selection of addresses associated with my account
      And I should see a link to create a new address
    When I follow the link to create a new address
    Then I should be on the add a new address page
    When I complete the form with an invalid address
    Then I should see a message stating my address is invalid
      And I should still be on the create a new address page

  Scenario: The address entered is not serviced
    Given I am signed in
      And I have items in my cart
      And I am on the shopping cart page
    Then I should on the shopping cart page
      And I should see the items I added
      And I should see a field for shipping estimate on each item
      And I should see a selection of addresses associated with my account
      And I should see a link to create a new address
    When I follow the link to create a new address
    Then I should be on the add a new address page
    When I complete the form with a valid address
    Then I should be on the checkout page
      And I should see a message stating the item can not be delivered to the address
