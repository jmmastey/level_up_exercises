Feature: EVE Central API - Quicklook
  As a developer
  I want to call EVE Central's Quicklook API method
  In order to access detailed order information from EVE Online's market

  Background:
    Given the web service domain is "api.eve-central.com"
    And the path for Quicklook is "/api/quicklook"

  Scenario: Quicklook a single item with no additional filters
    Given I am using VCR cassette "quicklook_item"
    When I send a POST request to Quicklook with the params:
      | typeid | 34 |
    Then the XML response should have "/evec_api/quicklook"
    And the XML response should have "//item" with text "34"
