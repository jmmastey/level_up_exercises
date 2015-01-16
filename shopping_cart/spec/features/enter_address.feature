Feature: Enter Address Info
  In order to receive my order
  As a customer
  I want to enter my address

  Scenario Outline: What to show on address page
    Given I am <logged_in>
    And I have <saved_address>
    And my cart has <number_of_items> items
    And I am on the <page_from> page
    When I click the checkout button
    Then I see <address_prompt>

  @happy
  Examples: Go to Address Page
    | logged_in     | saved_address      | number_of_items | page_from     | address_prompt                   |
    | logged in     | a saved address    | 1               | items         | address confirmation content     |
    | logged in     | no saved addresses | 1               | items         | add new address for user content |
    | logged in     | a saved address    | 1               | shopping cart | address confirmation content     |
    | logged in     | no saved addresses | 1               | shopping cart | add new address for user content |
    | not logged in | no saved addresses | 1               | items         | enter address for order content  |
    | not logged in | no saved addresses | 1               | shopping cart | enter address for order content  |

  @bad
  Examples: Do Not Proceed
    | logged in     | a saved address    | 0               | items         | no items message                 |
    | logged in     | a saved address    | 0               | shopping cart | no items message                 |
    | not logged in | no saved addresses | 0               | items         | no items message                 |
    | not logged in | no saved addresses | 0               | shopping cart | no items message                 |