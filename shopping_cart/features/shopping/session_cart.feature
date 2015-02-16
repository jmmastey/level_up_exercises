Feature: Cart Session

  Scenario: I have items on my cart and I am logged in
    Given I am signed in
      And I am on the shopping dashboard page
      And I have items in my cart
    Then I should see a link to my shopping cart
      And I should see an item count to the shopping cart icon
    When I follow the shopping cart link
    Then I should on the shopping cart page
      And I should see the items I added

  Scenario: I have items on my cart and I am not logged in
    Given I am not signed in
      And I am on the shopping dashboard page
      And I have items in my cart
    Then I should see a link to my shopping cart
      And I should see an item count to the shopping cart icon
    When I follow the shopping cart link
    Then I should see a flash message asking me to sign in
      And I should see a link for signing in
    Then I should on the sign in page
      And I should see a field for my username
      And I should see a field for my password
    When I fill in the username with "svajone"
      And I fill in the password with "svajone69"
      And click on the submit button
    Then I should on the shopping cart page
      And I should see the items I added
