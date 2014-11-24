Feature: User sign in
  As a user, I want to be able to sign in, signout, and be
  remembered.

  Scenario: A user signs in
    Given I am on the sign in page
    When I enter valid sign in credentials
    Then I should be on the main page
    And I should be signed in

  Scenario: A user tries sign ing in with bad credentials
    Given I am on the sign in page
    When I enter invalid sign in credentials
    Then I should be on the sign in page
    And I should see "Invalid email address or password"
    And I should see "Forgot your password?" link

  Scenario: A user leaves the site
    Given I am on the sign in page
    When I enter valid sign in credentials
    And I leave the site
    And I visit the main page
    Then I should be on the main page
    And I should be signed in
