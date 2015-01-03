Feature: User visits the home page
  In order to sign in/sign up/view achievements of congress
  As a user
  I want to visit the homepage

  Background:
    Given I am not logged in
      And I am on the homepage

  Scenario: Sees navigational links
    Then I see 'good deeds' link
      And I see 'bills' link
      And I see 'legislators' link


