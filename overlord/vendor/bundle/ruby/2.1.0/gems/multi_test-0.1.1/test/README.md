# How this gem is tested

We build a matrix of test cases from the gemfiles and scenarios directories.

The gemfiles contain each of the different gem configurations we want to test with. Then, for each gemfile, there's a scenarios file which lists the Ruby scripts from the scenarios directory that we'll run as tests in that gemfile's environment.

Success for each test case is simply that nothing was written to standard output.
