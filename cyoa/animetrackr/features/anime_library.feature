Feature: Anime library
  As a user
  I want to be able to interact with my personal anime library

  Background:
    Given I have an account
    And I am signed in
    And I am on my profile page

  Scenario: Must be signed in to search
    When I am signed out
    And I go to search for an anime
    Then I should be redirected to the sign in page

  Scenario: Search for anime
    Given I am on my profile page
    When I go to add an anime
    And search for 'Ghost in the shell'
    Then I expect to have search result for 'Ghost in the shell'
    And the results should have a community rating

  Scenario: Add anime details before adding it to library
    When I go to add an anime
    And search for 'Ghost in the shell'
    And add the first result
    And I should be able to enter details for my library
    And click add
    Then I should be redirected to the profile page
    And I should have an entry in my library

  Scenario Outline: Edit an existing library item
    Given I am currently watching <anime>
    When I am done watching <anime>
    Then I should see <anime> in the done watching section
    Examples:
      | anime              |
      | Wolf's Rain        |
      | Michiko to Hatchin |

  Scenario Outline: Remove an existing library item
    Given I am currently watching <anime>
    When  I delete the anime <anime>
    Then I should not see <anime> in my library
    Examples:
    | anime              |
    | InuYasha           |
    | Witch Hunter Robin |
