Feature: About Us page
  As a visitor interested in the site
  I want to read an About Us page
  To learn the context and purpose of the site including its purpose, intended
  audience, sponsors/creators, and further instructions including terms and
  privacy policy

Scenario: Learn who hosts and sponsors the site
  Given I am visiting the "About Us" page
  Then I see a heading for "Who Are We"

Scenario: Learn why the site exists
  Given I am visiting the "About Us" page
  Then I see a heading for "Why Are We Here"

Scenario: Learn who is expected to use the site
  Given I am visiting the "About Us" page
  Then I see a heading for "Who Are You"

Scenario: Learn about the services the site provides
  Given I am visiting the "About Us" page
  Then I see a heading for "What To Do"

Scenario: Find the privacy policy
  Given I am visiting the "About Us" page
  Then I see a heading for "About Privacy"

Scenario: Find the terms and conditions
  Given I am visiting the "About Us" page
  Then I see a heading for "Terms Of Use"
