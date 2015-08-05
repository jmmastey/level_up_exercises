Feature: Searching by Artist
  As a curious spotify user
  I should be able to search for an artist
  In order to see the graph of related artists

  Background: I am on the homepage
    Given I am on the homepage

  Scenario: Search for an artist already on spotify
    When I search for the artist "Black Sabbath"
    Then I should see a graph

  Scenario: Search for an artist with the wrong case
    When I search for the artist <artist>
    Then I should see a graph
    Examples:
      |     artist      |
      | "black sabbath" |
      | "bLaCk SaBBaTH" |
      | "BLACK SABBATH" |

  Scenario: Search for an artist not on spotify
    When I search for the artist "Tool"
    Then I should see that "Tool" is not on spotify

  Scenario: Search with an empty searchbox
    When I search for the artist ""
    Then I should see a graph

  Scenario Outline: Search with garbage input
    When I search for the artist <garbage>
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
    When I search for the artist "Everything in it's right place"
    Then I should see that "Everything in it's right place" is not on spotify


  Scenario: Search for an album
    When I search for the artist "The Dark Side of the Moon"
    Then I should see that "The Dark Side of the Moon" is not on spotify