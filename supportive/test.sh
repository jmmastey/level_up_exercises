cd sandbox/
./bin/rails runner ../supportive.rb > actual_output
diff actual_output expected_output
cd ../
