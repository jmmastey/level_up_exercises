Feature: user starts the program

  The user starts the program and the input file is parsed

  As a user
  I want to parse the input file
  So that I can read the data

  Scenario: Load the file
    Given The program is not yet started
    When  I start the program
    Then The input file should be parsed
  
