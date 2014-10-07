Feature: EVE Central API - Quicklook
  As a developer
  I want to call EVE Central's Quicklook API method
  In order to access detailed order information from EVE Online's market

  Background:
    Given the web service domain is "api.eve-central.com"
    And the path for Quicklook is "/api/quicklook"

  Scenario: Quicklook an item with no additional filters
    Given I am using VCR cassette "quicklook_item"
    When I send a POST request to Quicklook with the params:
      | typeid | 34 |
    Then the XML response should have "/evec_api/quicklook/item" with text "34"

  Scenario: Quicklook an item filtering on region
    Given I am using VCR cassette "quicklook_region_filter"
    When I send a POST request to Quicklook with the params:
      | typeid      |       34 |
      | regionlimit | 10000037 |
    Then the XML response should have "/evec_api/quicklook/regions/region" with text "Everyshore"
    And the XML response should have "/evec_api/quicklook/item" with text "34"
    And the XML response should not have "//order/region" without text "10000037"

  Scenario: Quicklook an item filtering on quantity
    Given I am using VCR cassette "quicklook_qty_filter"
    When I send a POST request to Quicklook with the params:
      | typeid  |     34 |
      | setminQ | 100000 |
    Then the XML response should have "/evec_api/quicklook/item" with text "34"
    And the XML response should have "/evec_api/quicklook/minqty" with text "100000"

  Scenario: Quicklook an item filtering on hours
    Given I am using VCR cassette "quicklook_hours_filter"
    When I send a POST request to Quicklook with the params:
      | typeid   | 34 |
      | sethours | 24 |
    Then the XML response should have "/evec_api/quicklook/item" with text "34"
    And the XML response should have "/evec_api/quicklook/hours" with text "24"
