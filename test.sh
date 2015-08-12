#!/bin/bash
echo "RSpec Tests:"
bundle exec rspec
echo "Cucumber"
bundle exec rake cucumber
