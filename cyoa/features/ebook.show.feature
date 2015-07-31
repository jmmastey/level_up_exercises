Feature:
  All ebooks should be on the library page.
  User pages should show a subset.
  Each book should have a dedicated page

  Background:
    Given there is a user with 5 ebooks
    And there is a user with 1 ebook
    And there is a user with 4 ebooks

  Scenario: View all the books
    Given the user is on the home page
    When the user clicks Library
    Then the user should be on the library page
    And the user should see exactly 10 ebooks

  Scenario: View book specific page
    Given the user is on the library page
    When the user opens an ebook
    Then the user should be on the ebook's page

  Scenario: See subset of all books
    Given the user is on the library page
    When the user opens an ebook
    And the user opens the author profile
    Then the user should see less than 10 ebooks
