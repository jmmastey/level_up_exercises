Feature: Search Item

  Scenario: My search yields matches equal to the keyword entered
    Given I am on the shopping dashboard page
    Then I should see a field for item search
    When I fill the item search with "dresser"
      And click on the submit button
    Then I should be the search result page
      And should be presented with items equal and equivalent to my search

  Scenario: My search yields matches equivalent to the keyword entered
    Given I am on the shopping dashboard page
    Then I should see a field for item search
    When I fill the item search with "dresser black"
      And click on the submit button
    Then I should be the search result page
      And should be presented with items equivalent to my search
  
  Scenario: My search yields no matches equal nor equivalent to the keyword entered
    Given I am on the shopping dashboard page
    Then I should see a field for item search
    When I fill the item search with "drizsler tagasd"
      And click on the submit button
    Then I should be the search result page
      And should be presented with no items
      And I should see a flash sign telling me no item was found


