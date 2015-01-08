# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def random_date(date=nil)
  date ||= 400.days.ago
  Faker::Time.between(date, Time.now).strftime('%Y-%m-%d')
end

200.times.each do |i|
  legislator = Legislator.new

  legislator.first_name = Faker::Name.first_name
  legislator.last_name = Faker::Name.last_name
  legislator.middle_name = "#{Faker::Name.first_name[0]}." if (rand(100) % 5).zero?
  legislator.name_suffix = %w(Jr. II III).sample if (rand(100) % 17).zero?

  legislator.chamber = %w(house senate).sample
  legislator.party = %w(R D).sample
  legislator.state = Faker::Address.state_abbr
  legislator.url = Faker::Internet.url('example.com')

  if legislator.chamber == 'house'
    legislator.title = 'Rep'
    legislator.district = rand(10)
  else
    legislator.title = 'Sen'
    legislator.state_rank = %w(senior junior).sample
  end

  index = i + 100;
  legislator.bioguide_id = legislator.last_name[0] + index.to_s.rjust(6, '0')
  legislator.phone = Faker::PhoneNumber.phone_number

  social_media_id = "#{legislator.title.capitalize}#{legislator.last_name.capitalize}"
  legislator.youtube_id = social_media_id
  legislator.facebook_id = social_media_id
  legislator.twitter_id = social_media_id
  legislator.save
end

200.times.each do
  bill = Bill.new
  bill.bill_type = %w(hr hres hjres hconres s sres sjres sconres).sample
  bill.official_title = Faker::Lorem.sentence.chomp('.')
  bill.chamber = %w(house senate).sample
  bill.congress = 114
  bill.number = rand(100..400)
  bill.url = Faker::Internet.url('example.com')
  bill.summary = Faker::Lorem.paragraph(10)
  introduced_on = random_date()
  bill.enacted = [true, false].sample
  bill.introduced_on = introduced_on
  bill.last_action_at = random_date(introduced_on)
  bill.enacted_at = bill.last_action_at if bill.enacted?
  bill.save
end

bills = Bill.all
legislators = Legislator.all

500.times.each do
  good_deed = GoodDeed.new
  good_deed.action = %w(voted enacted sponsored cosponsored).sample
  bill = bills.sample
  good_deed.bill_id = bill.id
  good_deed.chamber = bill.chamber
  good_deed.acted_at = rand(1..100).days.ago

  if good_deed.action == 'enacted'
    good_deed.text = "Public law #{bill.congress}-#{rand(100..200)}"
  end

  if good_deed.action.in? %w(sponsored cosponsored)
    legislator = legislators.sample
    good_deed.legislator_id = legislator.id
  end

  good_deed.save
end
