Feature: Related Artists
  As a curious spotify user
  I should be able to see related artists
  In order to get more information about the graph

  Background: We are on the homepage
    Given I am on the homepage

  Scenario Outline: We should be able to see related artists of a valid artist
    When I search for the artist "Black Sabbath"
    Then I should see <related> as a related artist
    Examples:
      | related        |
      | "Ozzy"         |
      | "Judas Priest" |
      | "Dio"          |
      | "Iron Maiden"  |

  Scenario Outline: We should be able to see related artists of a valid artist
    When I search for the artist "Green Day"
    Then I should see <related> as a related artist
    Examples:
      | related         |
      | "blink-182"     |
      | "The Offspring" |
      | "Sum 41"        |
      | "Simple Plan"   |


  Scenario Outline: We should be able to see related artists of a valid artist
    When I search for the artist "Mixtapes"
    Then I should see <related> as a related artist
    Examples:
      | related           |
      | "Fireworks"       |
      | "Polar Bear Club" |
      | "Such Gold"       |
      | "Candy Hearts"    |


  Scenario Outline: We should see no related artists for a failed search
    When I search for the artist <artist>
    Then I should see no related artists
    Examples:
      | artist |
      | "Tool" |
      | "c3p0" |