Feature: JSON lexer
  In order to support greater access to features
  we want JSON

  Background:
    Given a PrettyFormatter
    And a JSON lexer

  Scenario: Only a Feature
    Given the following JSON is parsed:
      """
      [
        {
          "comments": [
            {"value": "# language: no"}, 
            {"value": "# Another comment"}
          ],
          "description": "",
          "keyword": "Egenskap",
          "id": "kjapp",
          "name": "Kjapp",
          "tags": [],
          "uri": "test.feature"
        }
      ]
      """
    Then the outputted text should be:
      """
      # language: no
      # Another comment
      Egenskap: Kjapp
      """

  Scenario: Feature with scenarios and outlines
    Given the following JSON is parsed:
      """
      [
        {
          "comments": [],
          "keyword": "Feature",
          "id": "oh-hai",
          "name": "OH HAI",
          "tags": [{"name": "@one"}],
          "uri": "test.feature",
          "description": "",
          "elements":[
            {
              "comments": [],
              "tags": [],
              "keyword": "Scenario",
              "id": "oh-hai/fujin",
              "name": "Fujin",
              "description": "",
              "type": "scenario",
              "line": 4,
              "steps": [
                {
                  "comments": [],
                  "keyword": "Given ",
                  "name": "wind",
                  "line": 5
                },
                {
                  "comments": [],
                  "keyword": "Then ",
                  "name": "spirit",
                  "line": 6
                }
              ]
            },
            {
              "comments": [],
              "tags": [{"name": "@two"}],
              "keyword": "Scenario",
              "id": "oh-hai/_why",
              "name": "_why",
              "description": "",
              "type": "scenario",
              "line": 9,
              "steps": [
                {
                  "comments": [],
                  "keyword": "Given ",
                  "name": "chunky",
                  "line": 10
                },
                {
                  "comments": [],
                  "keyword": "Then ",
                  "name": "bacon",
                  "line": 11
                }
              ]
            },
            {
              "comments": [],
              "tags": [{"name": "@three"}, {"name": "@four"}],
              "keyword": "Scenario Outline",
              "id": "oh-hai/life",
              "name": "Life",
              "description": "",
              "type": "scenario_outline",
              "line": 14,
              "steps": [
                {
                  "comments": [],
                  "keyword": "Given ",
                  "name": "some <boredom>",
                  "line": 15
                }
              ],
              "examples": [
                {
                  "type": "examples",
                  "comments": [],
                  "tags": [{"name": "@five"}],
                  "keyword": "Examples",
                  "id": "oh-hai/life/real-life",
                  "name": "Real life",
                  "description": "",
                  "line": 18,
                  "rows": [
                    {
                      "comments": [],
                      "cells": ["boredom"],
                      "line": 19
                    },
                    {
                      "comments": [],
                      "cells": ["airport"],
                      "line": 20
                    },
                    {
                      "comments": [],
                      "cells": ["meeting"],
                      "line": 21
                    }
                  ]
                }
              ]
            },
            {
              "comments": [],
              "tags": [],
              "keyword": "Scenario",
              "id": "oh-hai/who-stole-my-mojo?",
              "name": "who stole my mojo?",
              "description": "",
              "type": "scenario",
              "line": 23,
              "steps": [
                {
                  "comments": [],
                  "keyword": "When ",
                  "name": "I was",
                  "line": 24,
                  "rows": [
                    {
                      "comments": [],
                      "line": 25,
                      "cells": ["asleep"]
                    }
                  ]
                },
                {
                  "comments": [],
                  "keyword": "And ",
                  "name": "so",
                  "line": 26,
                  "doc_string": {
                    "value": "innocent",
                    "line": 27
                  }
                }
              ]
            },
            {
              "comments": [{"value": "# The"}],
              "tags": [],
              "keyword": "Scenario Outline",
              "description": "",
              "type": "scenario_outline",
              "line": 32,
              "id": "oh-hai/with",
              "name": "with",
              "steps": [
                {
                  "comments": [{"value": "# all"}],
                  "keyword": "Then ",
                  "line": 34,
                  "name": "nice"
                }
              ],
              "examples": [
                {
                  "type": "examples",
                  "comments": [{"value": "# comments"}, {"value": "# everywhere"}],
                  "tags": [],
                  "keyword": "Examples",
                  "id": "oh-hai/with/an-example",
                  "name": "An example",
                  "description": "",
                  "line": 38,
                  "rows": [
                    {
                      "comments": [{"value": "# I mean"}],
                      "line": 40,
                      "cells": ["partout"]
                    },
                    {
                      "comments": [{"value": "# I really mean"}],
                      "line": 40,
                      "cells": ["bartout"]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
      """
    Then the outputted text should be:
      """
      @one
      Feature: OH HAI

        Scenario: Fujin
          Given wind
          Then spirit

        @two
        Scenario: _why
          Given chunky
          Then bacon

        @three @four
        Scenario Outline: Life
          Given some <boredom>

          @five
          Examples: Real life
            | boredom |
            | airport |
            | meeting |

        Scenario: who stole my mojo?
          When I was
            | asleep |
          And so
            \"\"\"
            innocent
            \"\"\"

        # The
        Scenario Outline: with
          # all
          Then nice

          # comments
          # everywhere
          Examples: An example
            # I mean
            | partout |
            # I really mean
            | bartout |
      """

  Scenario: Feature with Background
    Given the following JSON is parsed:
      """
      [
        {
          "comments": [],
          "description": "",
          "keyword": "Feature",
          "id": "kjapp",
          "name": "Kjapp",
          "tags": [],
          "uri": "test.feature",
          "elements": [
            {
              "type": "background",
              "comments": [],
              "description": "",
              "keyword": "Background",
              "line": 2,
              "name": "No idea what Kjapp means",
              "steps": [
                {
                  "comments": [],
                  "keyword": "Given ",
                  "line": 3,
                  "name": "I Google it"
                }
              ]
            },
            {
              "type": "scenario",
              "comments": [{"value": "# Writing JSON by hand sucks"}],
              "tags": [],
              "keyword": "Scenario",
              "id": "kjapp/",
              "name": "",
              "description": "",
              "line": 6,
              "steps": [
                {
                  "comments": [],
                  "keyword": "Then ",
                  "name": "I think it means \"fast\"",
                  "line": 7
                }
              ]
            }
          ]
        }
      ]
      """
    Then the outputted text should be:
      """
      Feature: Kjapp

        Background: No idea what Kjapp means
          Given I Google it

        # Writing JSON by hand sucks
        Scenario: 
          Then I think it means "fast"
      """
    
