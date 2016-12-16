
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

def visits(count, cohort, result)
  Array.new(count, "date" => "2014-03-20", "cohort" => cohort,
            "result" => result)
end
