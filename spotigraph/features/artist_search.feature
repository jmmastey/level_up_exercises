Feature: Searching by Artist
  As a curious Spotify user
  I should be able to search for an artist
  In order to see the graph of related artists

  Background: I am on the homepage for the website
    Given I am on the homepage

  Scenario: Will not see any errors on first site visit
    Then I see no error messages

  @javascript
  Scenario: Search for an artist already on spotify
    When I search for Black Sabbath at a depth 1
    Then I see a graph

  Scenario: Search for an artist already on spotify
    When I search for Black Sabbath at a depth 1
    Then I see no error messages

  @javascript
  Scenario Outline: Search for an artist with the wrong case
    When I search for <artist> at a depth 1
    Then I see a graph
    Examples:
      | artist        |
      | black sabbath |
      | bLaCk SaBBaTH |
      | BLACK SABBATH |

  @javascript
  Scenario: Search with an empty searchbox
    When I search with the artist field empty
    Then I see the welcome page

  Scenario Outline: Search for an artist not on spotify
    When I search for <artist> at a depth 1
    Then I see that <artist> is not on spotify
    Examples:
      | artist                                   |
      | back sabath                            |
      | blink182                               |
      | geen da                                |
      | ZbuTylzpfY                             |
      | ZZMJT7EDeJ                             |
      | cwlfbYBpcx                             |
      | oFA7assllL                             |
      | 59gM3gofl8                             |
      | Everything in its right place          |
      | ; DROP TABLE artists;                  |
      | alert();                               |