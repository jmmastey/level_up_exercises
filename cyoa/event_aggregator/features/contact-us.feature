Feature: Contact Us page
  As an inquisitive or helpful or griping user
  I want responsible party contacts to call, e-mail, and write letters to
  So I can get whatever's on my mind off my chest

Scenario: Find company contact phone number
  Given I am visiting the "Contact Us" page
  Then I see a heading for "Call Us"
  And I see a tel: link to the customer service phone number

Scenario: Find company contact e-mail address
  Given I am visiting the "Contact Us" page
  Then I see a heading for "E-Mail Us"
  And I see a mailto: link to the customer service e-mail address

Scenario: Find company written correspondence address
  Given I am visiting the "Contact Us" page
  Then I see a heading for "Send Us Mail"
  And I see the company mailing address
