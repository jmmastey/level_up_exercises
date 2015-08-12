Feature: Related Artists
  As a curious spotify user
  I should be able to see related artists
  In order to get more information about the graph

  Background: We are on the homepage
    Given I am on the homepage

  @javascript
  Scenario Outline: We should be able to see related artists of a valid artist
    When I search for the artist "Black Sabbath" at a depth 2
    Then I should see <related> as a related artist of "Black Sabbath"
    Examples:
      | related        |
      | "Ozzy Osbourne"|
      | "Judas Priest" |
      | "Dio"          |
      | "Iron Maiden"  |

  @javascript
  Scenario Outline: We should be able to see related artists of a valid artist
    When I search for the artist "Green Day" at a depth 2
    Then I should see <related> as a related artist of "Green Day"
    Examples:
      | related         |
      | "blink-182"     |
      | "The Offspring" |
      | "Sum 41"        |
      | "Simple Plan"   |

  @javascript
  Scenario Outline: We should be able to see related artists of a valid artist
    When I search for the artist "Mixtapes" at a depth 2
    Then I should see <related> as a related artist of "Mixtapes"
    Examples:
      | related           |
      | "Fireworks"       |
      | "Polar Bear Club" |
      | "Such Gold"       |
      | "Candy Hearts"    |

  @javascript
  Scenario Outline: We should see no related artists for a failed search
    When I search for the artist <artist> at a depth 2
    Then I should see no related artists
    Examples:
      | artist       |
      | "glsvrnmqGa" |
      | "YcMun2IFWM" |
      | "4OXq6GP9Ss" |
      | "c3p0"       |