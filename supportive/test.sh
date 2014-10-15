cd sandbox/
./bin/rails runner ../supportive.rb > ../actual_output
cd ../
diff actual_output expected_output
