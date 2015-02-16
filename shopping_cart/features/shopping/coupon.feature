Feature: Coupon

  Scenario: Coupon is valid
    Given I am signed in
      And I have items in my cart
      And I am on the checkout page
    Then I should be on the checkout page
      And I should see the items I added
      And I should see the total cost of all the items
      And I should see a field for coupon
    When I fiill in the coupon with "svajonelove"
      And click on submit
    Then I should see a message telling me my coupon was accepted
      And I should see my price change

  Scenario: Coupon is expired
    Given I am signed in
      And I have items in my cart
      And I am on the checkout page
    Then I should be on the checkout page
      And I should see the items I added
      And I should see the total cost of all the items
      And I should see a field for coupon
    When I fiill in the coupon with "svajonelovemetoo"
      And click on submit
    Then I should see a message telling me my coupon is expired
      And I should see my price unchanged

  Scenario: Coupon is not valid
    Given I am signed in
      And I have items in my cart
      And I am on the checkout page
    Then I should be on the checkout page
      And I should see the items I added
      And I should see the total cost of all the items
      And I should see a field for coupon
    When I fiill in the coupon with "vavamamatata"
      And click on submit
    Then I should see a message telling me my coupon is not valid
      And I should see my price unchanged
