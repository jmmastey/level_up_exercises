Feature: Signing in
  As a website visitor
  I want to sign in
  Because I want to customize my preferences

Scenario: Sign in
  Given I am signed out
  And I have an account
  When I visit my account
  And I sign in correctly
  Then I see my account

Scenario: Incorrect email
  Given I am signed out
  And I have an account
  When I sign in with the wrong email
  Then I see an invalid email or password message

Scenario: Incorrect password
  Given I am signed out
  And I have an account
  When I sign in with the wrong password
  Then I see an invalid email or password message
