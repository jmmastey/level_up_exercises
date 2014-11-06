# require 'open-uri'
# require 'nokogiri'
# require 'capybara/poltergeist'
# 
# 	def scrape
# 	  session = Capybara::Session.new(:poltergeist)
# 	  session.visit "http://www.theatreinchicago.com/opening/openingnight.php"
# 	  current_event_month = session.find(:xpath, "//div[@id='quickCalender']/table/tbody/tr/th[3]/a[@class='headerNav']").text
# 	  current_month = Time.now.strftime("%b %Y")
# 	  if(current_month==current_event_month)
# 		puts "Not downloading any new events"
# 	  else
# 		puts "Downloading new data"
# 		session.find(:xpath, "//div[@id='quickCalender']/table/tbody/tr/th[3]/a[@class='headerNav']").click
# 		sleep(1)
# 		File.open('tmp.html', 'w') { |file| file.write(session.html) }
# 		File.open('tmp.xml', 'w') { |file| file.write(session.html) }
# 	  end 
# 	end
# 
# scrape
