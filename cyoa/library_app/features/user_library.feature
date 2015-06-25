
Feature: view and add books to the user's library
  
  In order to maintain my library
  As the library user
  I should search for, add, and remove books from my library, save comments about them and recommend them.

  Scenario: user searches for book and adds it to her library
    Given I am logged in
    And I am on the home page
    When I click on Book Search
    And I search for a book
    Then I add it to my library
    And I see that it is stored in my library

  Scenario: user clicks on a link for a book in her library and sees detailed info about the book
    Given I am logged in
    And I have a book in my library
    When I click on my library
    And I select a book
    Then I can see detailed information about the book

  Scenario: users can recommend books and see books recommended by others
    Given I am logged in
    And I have a book in my library
    When I click on my library
    And I select a book
    And I click on the recommend button
    Then I see a message indicating the book is recommended

    Given I am not logged in
    When I click on Recommended Books
    Then I see books recommended by users

  Scenario: User can write and save comments about the book and see them
    Given I am logged in
    And I have a book in my library
    When I click on my library
    And I select a book
    And I write a comment about the book
    Then I expect to see a message indicating my comment was successfully added 
   
    Given I am on my library page
    When I select a book
    Then I can see comments that I have written about the book

    Given I am on my library page
    When I select a book
    And I delete a comment about that book
    Then I see the comment was deleted
    And I see the comment no longer exists on the book page

  Scenario: User can delete books from library
    Given I am logged in
    And I have a book in my library
    When I click on my library
    And I select a book
    And I click to delete the book
    Then I see a message indicating the book was deleted
    And I see that the book is no longer in my library

