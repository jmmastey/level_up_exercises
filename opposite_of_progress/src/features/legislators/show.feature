Feature: Legislator page
  In order to see the details about a legislator
  As as user
  I want to see the page of that legislator

  Background:
    Given a legislator exists

  Scenario: See pictures
    When I visit that legislator's page
    Then I see the details about that legislator
      And I see the picture of that legislator

  Scenario: See sponsorships
    Given legislator has previous sponsoships and cosponsorships
    When I visit that legislator's page
    Then I should see cosponsorships
      And I should see sponsorships

  # Scenario: Guest does not see favorite button in legislator's page
  #   Given I am not logged in
  #     And I am on that legislator's page
  #   Then I should not see favorite button

  # Scenario: Logged in user see favorite button in legislator's page
  #   Given I am logged in
  #     And I am on that legislator's page
  #   Then I should see favorite button

  # Scenario: User favorites a legislator from legislator's page
  #   Given I am logged in
  #     And I am on that legislator's page
  #   When I favorite that legislator
  #   Then I should see that legislator favorited

  # Scenario: User unfavorites a legislator from legislator's page
  #   Given I have favorited the legislator
  #     And I am logged in
  #     And I am on that legislator's page
  #   When I favorite that legislator
  #   Then I should see that legislator favorited
