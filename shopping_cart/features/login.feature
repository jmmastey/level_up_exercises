Feature: Login shopping cart

  As a customer I want to be able to login into my own account
  so I can create orders as well as retrieve previous items/orders

  Scenario:login into account
    Given I am on the login page
    When I enter my username and password
    Then I am able to successfully login

  Scenario:invalid username
    Given I am on the login page
    When I enter an invalid username and a valid password
    Then I should receive an error message specifying an invalid login

  Scenario:invalid password
    Given I am on the login page
    When I enter a valid username and an invalid password
    Then I should receive an error message specifying an invalid login

  Scenario:add item as anonymous user
    Given I am not logged in
    And I am on the item page
    When I try to add an item
    Then I see an item was added to the shopping cart

  Scenario:login and keep items in the shopping cart
    Given I am not logged in
    And I add a sony playstation to  my shopping cart
    When I log into my application
    Then I see my shopping cart contains a sony playstation

  Scenario:combining items added and saved as an anonymous user with items added as a logged in user
    Given I am not logged in
    And have previous items saved in my account
    And I add a toy car to my shopping cart
    When I log into my account
    Then I should see my toy car along with previously added items