Feature:
  Owners should be able to edit and delete ebooks

  Scenario: Get to profile page
    Given there is a logged in user on the homepage with 1 ebook
    When the user clicks My Profile
    Then the user should be on their profile page

  Scenario: Get to edit book page
    Given there is a logged in user on their profile page with 1 ebook
    When the user opens an ebook
    And the user clicks Edit
    Then the user should be on the edit book page

  Scenario: update an ebook
    Given there is a logged in user on the edit book page with 1 ebook
    When the user changes the book's title
    And the user presses Update Ebook
    Then the ebook should be successfully updated
    And the user should be on the ebook's page

  Scenario: delete an ebook
    Given there is a logged in user on the My Books page with 1 ebook
    When the user deletes the first ebook
    Then the ebook should be successfully destroyed
