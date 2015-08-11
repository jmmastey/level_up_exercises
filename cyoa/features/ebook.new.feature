Feature:
  Anonymous and Authenticated users can see links to share a new book.
  Only Authenticated users can get to the new ebook page.
  Completing and submitting the new ebook form creates a book

  Scenario: Anonymous User
    Given the user is on the home page
    When the user clicks Share a Book
    Then the user should be on the login page

  Scenario: Anonymous User logs in
    Given there is a user
    And the user is on the home page
    When the user clicks Share a Book
    And the user fills in the login form
    And the user presses Log In
    Then the user should be on the new ebook page

  Scenario: Authenticated User tries homepage link
    Given there is a logged in user on the homepage with 0 ebooks
    When the user clicks Share a Book
    Then the user should be on the new ebook page

  Scenario: Authenticated User tries library link
    Given there is a logged in user on the library page with 0 ebooks
    When the user clicks New Ebook
    Then the user should be on the new ebook page

  Scenario: Authenticated User tries my books link
    Given there is a logged in user on the My Books page with 0 ebooks
    When the user clicks New Ebook
    Then the user should be on the new ebook page

  Scenario: Make a new bebook
    Given there is a logged in user on the new ebook page with 0 ebooks
    When the user fills out the new ebook form
    And the user presses Create Ebook
    Then the user will have created an ebook
