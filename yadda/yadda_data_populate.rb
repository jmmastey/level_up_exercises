require_relative 'connection'
require 'ffaker'
require 'ffaker/address_us'
require 'populator'

 10.times.each do |n|
   @connection.connection.execute("INSERT INTO yadda.addresses (city, line_1, line_2, state, zip_code) VALUES('" +
   Faker::Address.city.gsub("'", " ") + "','" +
   Faker::Address.street_name.gsub("'", " ") + "','" +
   Faker::Address.street_address.gsub("'", " ")+"','" +
   Faker::AddressUS.state+"','" +
   Faker::AddressUS.zip_code+"')");
 end

(1..110).each do |n|
   r = Random.new
   sql = "INSERT INTO yadda.users(name, email, password, phone, address_id) VALUES('"+Faker::Name.name.gsub("'", " ")+
    "','#{Faker::Internet.email}','#{Faker::Internet.password}','#{Faker::PhoneNumber.phone_number}',"+r.rand(1..10).to_s+")"
   @connection.connection.execute(sql);
end
 @connection.connection.execute("INSERT INTO yadda.beer_categories (category) VALUES('British Ale')," +
   "('Irish Ale'),"+
   "('North American Ale'),('German Ale'),('Belgian and French Ale'),"+
   "('International Ale'),('German Lager'),('North American Lager'),"+
   "('Other Lager'),('International Lager'),('Other Style')");

(1..11).each do |n|
  (1..10).each do |m|
    @connection.connection.execute("INSERT INTO yadda.beer_styles(category_id, style)
     VALUES(#{n},'"+Populator.words(1..3).titleize+"')")
  end
end

addresses = "SELECT * from yadda.addresses"
@result_addresses = @connection.connection.execute(addresses);
@result_addresses.each do |row|
  r = Random.new
  sql = "INSERT INTO yadda.breweries(name, address_id, founding_year, description)
  VALUES('"+
   Populator.words(1..3).titleize+"',
   "+""+
  row["id"]+","+"#{r.rand(1960...1985)},'')"
  @connection.connection.execute(sql);
end

breweries = "select * from yadda.breweries"
@result_breweries = @connection.connection.execute(breweries);
(1..10).each do |m|
  @result_breweries.each do |row|
    r= Random.new
    @connection.connection.execute("INSERT INTO yadda.beers(style_id, brewery_id, brewing_year, description)
    VALUES('"+r.rand(1..110).to_s+"',"+
     row["id"]+","+"#{r.rand(1960...1985)},'')")
  end
end


(1..5).each do |n|
  (1..100).each do |m|
    r=Random.new
   @connection.connection.execute("INSERT INTO yadda.ratings(beer_id, user_id,  look, smell, taste, feel, overall)
     VALUES("+m.to_s+",#{m+1},"+r.rand(1..5).to_s+","+
      r.rand(1..5).to_s+","+r.rand(1..5).to_s+","+r.rand(1..5).to_s+","+r.rand(1..5).to_s+")")
   end
end