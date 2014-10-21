# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
MODEL_COUNTS = {
  user: 1000,
  show: 1000,
  performer: 1000,
  review: 1000,
}

MODEL_COUNTS[:user].times { FactoryGirl.create(:user) }
MODEL_COUNTS[:show].times { FactoryGirl.create(:show) }
MODEL_COUNTS[:performer].times { FactoryGirl.create(:performer, :with_shows) }
MODEL_COUNTS[:review].times { FactoryGirl.create(:review) }
