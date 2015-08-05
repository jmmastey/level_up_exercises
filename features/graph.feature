Feature: Related artists graph
  As a curious spotify user
  I should be able to see the related artists graph
  In order to have a better idea how the network of spotify artists works

  Background: We are on the webpage
    Given I am on the homepage
    And I search for the artist "Black Sabbath"

  Scenario: Should be able to select nodes on the graph
    When I click the "Ozzy" node
    Then The "Ozzy" node should highlight