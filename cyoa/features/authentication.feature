Feature: Authentication
  In order to use any part of the app
  As a curious redditor
  I should first need to login or sign up

  @happy
  Scenario Outline: Unauthenticated page visit
    Given I'm not authenticated
    When I visit <page>
    Then I am redirected to log in

  Examples:
    | page              |
    | "/"               |
    | "/show/next"      |
    | "/show/prev"      |
    | "/channel/next"   |
    | "/channel/prev"   |
    | "/channel/to"     |
    | "/channel"        |
    | "/channel/status" |

 @happy
  Scenario: First Log In
    Given I'm at the signup landing
    When I create an account
    And log in for the first time
    Then I see the Movie Trailers channel
    When I open the guide
    Then all default channels are present