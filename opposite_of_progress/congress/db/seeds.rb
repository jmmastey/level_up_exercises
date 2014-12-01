# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

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

Bill.create(bill_id: 'hjres124-113',
            bill_type: 'hjres',
            number: '164',
            congress: '113',
            chamber: 'house',
            introduced_on: '2014-09-09',
            last_action_at: '2014-09-19',
            last_vote_at: '2014-09-18',
            last_version_on: '2014-09-17',
            official_title: 'Making continuing appropriations for fiscal year.',
            short_title: 'Continuing Appropriations Resolution, 2015')

Bill.create(bill_id: 'hr5404-113',
            bill_type: 'hr',
            number: '175',
            congress: '113',
            chamber: 'house',
            introduced_on: '2014-09-08',
            last_action_at: '2014-09-26',
            last_vote_at: '2014-09-18',
            last_version_on: '2014-09-20',
            official_title: 'To amend title 38, United States Code.',
            short_title: 'VA Expiring Authorities Act of 2014')
