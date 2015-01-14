Feature: Register new user As an unauthenticated new user
  I want to register a new account for myself
  So I can access customization features

Scenario: Find new user registration link on home page
  Given I am an unauthenticated user visiting the "home" page
  Then I see a link for "Sign up"

Scenario: Acccess new user registration page
  Given I am an unauthenticated user visiting the "sign up" page
  Then I see an input for "Email"
  And I see an input for "Password"
  And I see a "Sign up" button

Scenario: Registration attempt with all fields filled granted
  Given I fill out the registration form as "Jack"
  When I press the "Sign up" button
  Then I see text "Welcome, Jack Kcajsohn"

Scenario: Registration attempt with empty e-mail address denied
  Given I fill out the registration form as "Jack"
  But I leave the "email" field blank
  When I press the "Sign up" button
  Then I see text "Email can't be blank"

Scenario: Regisration attempt with empty password denied
  Given I fill out the registration form as "Jack"
  But I leave the "Password" field blank
  When I press the "Sign up" button
  Then I see text "Password can't be blank"

Scenario: Registration attempt with unconfirmed password denied
  Given I fill out the registration form as "Jack"
  But I leave the "Password confirmation" field blank
  When I press the "Sign up" button
  Then I see text "Password confirmation doesn't match password"

Scenario: Registration attempt with password under 8 characters denied
  Given I fill out the registration form as "Jack"
  But I type "1234567" into the "Password" field
  And I type "1234567" into the "Password confirmation" field
  When I press the "Sign up" button
  Then I see text "Password is too short"
   
Scenario: Registration attempt with duplicate e-mail address denied
  Given There is a registered user "Jack"
  When I register as user "Jack"
  Then I see text "Email has already been taken"
