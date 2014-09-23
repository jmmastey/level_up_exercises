require 'pg'
require 'faker'

def populate_breweries(conn, brewery_count)

  puts "Populating Breweries"

  query = "
  INSERT INTO breweries (
      name,
      year_founded,
      address,
      city,
      state,
      description,
      created_at,
      updated_at,
      created_by,
      updated_by
  )
  VALUES(
      $1,
      $2,
      $3,
      $4,
      $5,
      $6,
      now(),
      now(),
      current_user,
      current_user
  )"

  brewery_count.times do
    params = []
    params.push(Faker::Company.name)
    params.push(Random.new.rand(1871..2014).to_s)
    params.push(Faker::Address.street_address)
    params.push(Faker::Address.city)
    params.push(Faker::Address.state_abbr)
    params.push(Faker::Lorem.sentence)

    begin
      conn.exec_params(query, params)
    rescue
      next
    end
  end
end

def populate_beer_styles(conn, beer_styles)
  puts "Populating beer styles"

  query = "
  INSERT INTO beer_styles (
      style,
      created_at,
      updated_at,
      created_by,
      updated_by
  )
  VALUES(
      $1,
      now(),
      now(),
      current_user,
      current_user
  )"

  beer_styles.each { |style| conn.exec_params(query, [style]) }
end

def populate_beers(conn, beer_count, brewery_count, beer_style_count)
  # Drown the world with 1 million beers

  puts "Populating beers"

  query = "
  INSERT INTO beers(
      brewery_id,
      beer_style_id,
      name,
      description,
      created_at,
      updated_at,
      created_by,
      updated_by
  )
  VALUES(
      $1,
      $2,
      $3,
      $4,
      now(),
      now(),
      current_user,
      current_user
  )"


  beer_count.times do
    params = []
    params.push(Random.new.rand(1..brewery_count))
    params.push(Random.new.rand(1..beer_style_count))
    params.push(Faker::Commerce.product_name)
    params.push(Faker::Lorem.sentence)

    begin
      conn.exec_params(query, params)
    rescue
      next
    end
  end
end

def populate_users(conn, user_count)
  # Give us Aurora. That's about 200k in people

  puts "Populating users"
  blood_types = ['A', 'B', 'O', 'A-', 'B-', 'O-', 'A+', 'B+', 'O+']

  #binding.pry
  query = "
    INSERT INTO users (
        first_name,
        last_name,
        email,
        birth_date,
        blood_type,
        created_at,
        updated_at,
        created_by,
        updated_by
    )
    VALUES(
        $1,
        $2,
        $3,
        $4,
        $5,
        now(),
        now(),
        current_user,
        current_user
    )
  "
  user_count.times do
    params = []

    first_name = Faker::Name.first_name
    last_name= Faker::Name.last_name

    params.push(first_name)
    params.push(last_name)
    params.push(Faker::Internet.free_email(first_name+"_"+last_name+rand(1..100).to_s))
    params.push(Time.at(rand * Time.now.to_i).strftime("%Y-%m-%d"))
    params.push(blood_types.sample)

    #binding.pry
    begin
      conn.exec_params(query, params)
    rescue
      next
    end
  end
end

def rate_beers(conn, user_count, beer_count)

  puts "Rating Beers"

  query = "
    INSERT INTO ratings (
        user_id,
        beer_id,
        rating,
        comment,
        created_at,
        updated_at,
        created_by,
        updated_by
    )
    VALUES(
        $1,
        $2,
        $3,
        $4,
        $5,
        now(),
        current_user,
        current_user
    )
  "

  (user_count * 2).times do
    params = []
    params.push(Random.new.rand(1..user_count))
    params.push(Random.new.rand(1..beer_count))
    params.push(Random.new.rand(1..5))
    params.push(Faker::Lorem.sentence)
    params.push(Time.at(Random.new.rand(0.95..1) * Time.now.to_i).strftime("%Y-%m-%d %H:%M:%S"))

    begin
      conn.exec_params(query, params)
    rescue
      next
    end

  end

end

brewery_count = 10000
beer_count    = 1000000
user_count    = 200000

# List O' Beer styles
beer_styles = [
  "Amber Ale",
  "Barleywine",
  "Belgian Dark Ale",
  "Belgian Dubbel",
  "Belgian Pale Ale",
  "Belgian Strong Dark",
  "Belgian Strong Pale",
  "Belgian Trippel",
  "Brown Ale Hefeweizen",
  "IPA",
  "Lambic",
  "Pale Ale",
  "Pilsner",
  "Porter",
  "Saison",
  "Wheat Beer"
]

beer_style_count = beer_styles.count

conn = PG::Connection.open(host: 'localhost', dbname: 'yadda')

populate_breweries(conn, brewery_count)
populate_beer_styles(conn, beer_styles)
populate_beers(conn, beer_count, brewery_count, beer_style_count)
populate_users(conn, user_count)

rate_beers(conn, user_count, beer_count)


