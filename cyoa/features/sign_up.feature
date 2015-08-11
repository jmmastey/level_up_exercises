Feature: Signing up
  As a website visitor
  I want to sign in
  Because I want to customize my preferences

Scenario: Sign up
  Given I am signed out
  When I sign up
  Then I see a welcome message

Scenario: Email already taken
  Given I am signed out
  When I sign up with a used email
  Then I see an email already taken message

Scenario: Invalid email
  Given I am signed out
  When I sign up with an invalid email
  Then I see an invalid email error message

Scenario: Inadequate password
  Given I am signed out
  When I sign up with a short password
  Then I see an bad password error message
