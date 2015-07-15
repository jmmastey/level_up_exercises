#encoding: utf-8

Feature: Bad Logging In
  In order to log in and view my cart
  As an online shopper
  I should enter valid credentials

  @happy
  Scenario: I log in while in a guest session
    Given I have an open session with items in my cart
    And I am not logged in
    And I have an account on the shopping site
    When I log in
    Then my items will still be in my shopping cart

  @happy
  Scenario: I log out while in a registered user session
    Given I have an open session with items in my cart
    And I am logged in
    When I log out
    Then my my cart should be empty

  @happy
  Scenario: Merging carts
    Given I have two open sessions with different items in each cart
    And I am not logged in on either session
    And I have an account on the shopping site
    When I log into both sessions
    Then my items from both sessions will merge into my login cart

  @happy
  Scenario: I enter valid credentials
    Given I have an account on the shopping site
    When I correctly enter my username and password
    Then I will be taken to the home page

  @bad
  Scenario: I enter invalid credentials
    Given I have an account on the shopping site
    When I incorrectly enter my username and password
    Then I will not be taken to the home page
    And an invalid credential error message will appear

  @bad
  Scenario: I enter nothing
    Given I have an account on the shopping site
    When I enter nothing into the username and password fields
    Then I will not be taken to the home page
    And an invalid credential error message will appear
