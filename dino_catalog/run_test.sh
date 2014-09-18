cat test_data/test_script | ruby ./dinodex.rb test_data/african_dinosaur_export.csv test_data/dinodex.csv > ActualOutput
diff ActualOutput test_data/ExpectedOutput
