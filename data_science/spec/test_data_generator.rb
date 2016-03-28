require 'json'

data = [{"date":"2014-03-20","cohort":"A","result":0}] * 700 +
       [{"date":"2014-03-20","cohort":"A","result":1}] * 32  +
       [{"date":"2014-03-20","cohort":"B","result":0}] * 950 +
       [{"date":"2014-03-20","cohort":"B","result":1}] * 13
               
File.open("test_data.json", "w") do |f|
  f.write(data.to_json)
end