Feature: Activity Feed
  As a user
  I want to have a running feed of the activities on my profile

  Background:
    Given I am authenticated
    And I am on my profile page

  Scenario Outline: Activity feeds shows anime added to library
    When I add a new anime <anime>
    And I am on my profile page
    Then I should see my activity feed saying I added <anime>
    Examples:
    | anime       |
    | Wolf's Rain |
    | Trigun      |

  Scenario Outline: Activity feed shows updates to anime in library
    When I add a new anime <anime>
    And I change the status of <anime> to <status>
    And I am on my profile page
    Then I should see my activity feed saying that I am <status> watching <anime>
    Examples:
    | anime              | status    |
    | Wolf's Rain        | Done      |
    | Michiko to Hatchin | Currently |

  Scenario: Activity feed shows anime moved to wishlist
    When I am currently watching InuYasha
    And I change the status of InuYasha to Wishlist
    And I am on my profile page
    Then I should see my activity feed saying that I added Inuyasha to wishlist
