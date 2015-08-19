Feature: Related Artists
  As a curious Spotify user
  I should be able to see the related artists
  In order to get more information about relationships between artists

  Background: I am on the homepage of the website
    Given I am on the homepage

  @javascript
  Scenario Outline: We should be able to see related artists of a valid artist
    When I search for the artist <artist> at a depth 2
    Then I see <related> as a related artist of <artist>
    Examples:
      | artist          | related          |
      | "Black Sabbath" | "Ozzy Osbourne"  |
      | "Black Sabbath" | "Judas Priest"   |
      | "Black Sabbath" | "Dio"            |
      | "Black Sabbath" | "Iron Maiden"    |
      | "Ozzy Osbourne" | "Dio"            |
      | "Ozzy Osbourne" | "KISS"           |
      | "Ozzy Osbourne" | "Bruce Dickinson"|
      | "Ozzy Osbourne" | "Rainbow"        |
      | "Radiohead"     | "Muse"           |
      | "Radiohead"     | "Pixies"         |

  @javascript
  Scenario Outline: We should see no related artists for a failed search
    When I search for the artist <artist> at a depth 2
    Then I see no related artists
    Examples:
      | artist       |
      | "glsvrnmqGa" |
      | "YcMun2IFWM" |
      | "4OXq6GP9Ss" |
      | "c3p0"       |