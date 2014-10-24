# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Legislator.create(bioguide_id: 'B000911',
                  birthday: '1946-11-11',
                  chamber: 'house',
                  party: 'D',
                  title: 'Rep',
                  term_start: '2013-01-03',
                  term_end: '2015-01-03',
                  gender: 'F',
                  first_name: 'Corrine',
                  nickname: nil,
                  middle_name: nil,
                  last_name: 'Brown',
                  state: 'FL',
                  twitter_id: 'RepCorrineBrown',
                  facebook_id: '179120958813519')

Legislator.create(bioguide_id: 'B000944',
                  birthday: '1952-11-09',
                  chamber: 'senate',
                  party: 'D',
                  title: 'Sen',
                  term_start: '2013-01-03',
                  term_end: '2019-01-03',
                  gender: 'M',
                  first_name: 'Sherrod',
                  nickname: nil,
                  middle_name: nil,
                  last_name: 'Brown',
                  state: 'OH',
                  twitter_id: 'SenSherrodBrown',
                  facebook_id: nil)
