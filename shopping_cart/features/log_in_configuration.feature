Feature: Log-in
  In order to log-in
  As a user
  I want to log-in
  So that I can prevent unauthorized access

  Scenario: Log-in as a user with incorrect username
    Given I am on the home page
    And I am a registered user
    When I fill in the incorrect username
    Then I should be prompted that the username and/or password is invalid
    And the option to be directed to reset instructions

  Scenario: Log-in as a user with incorrect password
    Given I am on the home page
    And I am a registered user
    When I fill in the incorrect password
    Then I should be prompted that the username and/or password is invalid
    And the option to be directed to reset instructions

  Scenario: Log-in as a user with incorrect username and password
    Given I am on the home page
    And I am a registered user
    When I fill in the incorrect username and password
    Then I should be prompted that the username and/or password is invalid
    And the option to be directed to reset instructions

  Scenario: Seeing shopping cart history with non-existing items from a previous log-in
    Given I had items added from a prior unfinished checkout
    And some of those items no longer exist
    When I log-in
    Then I should have the still existing items in my shopping cart
    And should see a notification for the items that no longer exist
