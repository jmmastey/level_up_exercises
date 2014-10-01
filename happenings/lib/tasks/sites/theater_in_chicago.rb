# File theater_in_chicago.rb

s = "http://www.theatreinchicago.com/"
site = "http://www.theatreinchicago.com/opening/CalendarMonthlyResponse.php?ran=6563&month=10&year=2014"
doc = Nokogiri::HTML(open(site))
doc.css('#resultsCol').css(".row").each do |post|
  @job = Job.new
  @job.link  = s + post.children[1].attributes["href"].value
  @job.title =  post.css(".jobtitle").children.text
  @job.company =  post.css(".company").first.children.text
  @job.haveapplied = false
  @job.interested = true
  @job.referred = s
  @job.save
end