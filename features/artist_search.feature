Feature: Searching by Artist
  As a curious spotify user
  I should be able to search for an artist
  In order to see the graph of related artists

  Background: I am on the homepage for the website
    Given I am on the homepage

  Scenario: Should not see any errors on first site visit
    Then I should see no error messages

  @javascript
  Scenario: Search for an artist already on spotify
    When I search for the artist "Black Sabbath" at a depth 1
    Then I should see a graph

  Scenario: Search for an artist already on spotify
    When I search for the artist "Black Sabbath" at a depth 1
    Then I should see no error messages

  @javascript
  Scenario Outline: Search for an artist with the wrong case
    When I search for the artist <artist> at a depth 1
    Then I should see a graph
    Examples:
      | artist          |
      | "black sabbath" |
      | "bLaCk SaBBaTH" |
      | "BLACK SABBATH" |

  @javascript
  Scenario: Search with an empty searchbox
    When I search for the artist "" at a depth 1
    Then I should see a graph

  Scenario Outline: Search for an artist not on spotify
    When I search for the artist <artist> at a depth 1
    Then I should see that <artist> is not on spotify
    Examples:
      | artist        |
      | "back sabath" |
      | "blink182"    |
      | "geen da"     |

  Scenario Outline: Search with garbage input
    When I search for the artist <garbage> at a depth 1
    Then I should see that <garbage> is not on spotify
    Examples:
      | garbage      |
      | "glsvrnmqGa" |
      | "YcMun2IFWM" |
      | "4OXq6GP9Ss" |
      | "93Z8Cx8OjC" |
      | "bXttT0cQOw" |
      | "ZbuTylzpfY" |
      | "ZZMJT7EDeJ" |
      | "cwlfbYBpcx" |
      | "oFA7assllL" |
      | "59gM3gofl8" |

  Scenario: Search for a song
    When I search for the artist "Everything in its right place" at a depth 1
    Then I should see that "Everything in its right place" is not on spotify


  Scenario: Search for an album
    When I search for the artist "Sing Sing Death House" at a depth 1
    Then I should see that "Sing Sing Death House" is not on spotify