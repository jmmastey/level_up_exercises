
Feature: view and add books to the user's library
  
  In order to maintain my library
  As the library user
  I should search for, add, and remove books from my library

  Scenario: user searches for book and adds to library
    Given I am logged in
    And I am on the home page
    When I click on Book Search
    And I search for a book
    Then I add it to my library
    And I see that it is stored in my library

  Scenario: user clicks on a link for a book in his library and sees detailed info about the book
    Given I am logged in
    And I have a book in my library
    When I click on my library
    And I select a book
    Then I can see detailed information about the book
