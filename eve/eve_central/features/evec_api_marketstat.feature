Feature: EVE Central API - Marketstat
  As a developer
  I want to call EVE Central's Marketstat API method
  In order to access statistics of EVE Online's market

  Background:
    Given the web service domain is "api.eve-central.com"
    And the path for Marketstat is "/api/marketstat"

  Scenario: Getting statistics for a single item
    Given I am using VCR cassette "marketstat_single_item"
    When I send a POST request to Marketstat with the params:
      | typeid | 34 |
    Then the XML response should have "//type" with "id" attribute set to "34"
    And the XML response should not have "//type" with "id" attribute not set to "34"

  Scenario: Getting statistics for multiple items
    Given I am using VCR cassette "marketstat_multiple_items"
    When I send a POST request to Marketstat with the params:
      | typeid | 34,35 |
    Then the XML response should have "//type" with "id" attribute set to "34"
    And the XML response should have "//type" with "id" attribute set to "35"
    And the XML response should not have "//type[@id!='34'][@id!='35']"
