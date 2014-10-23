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

def execute_with_progress(num, title)
  #progress = ProgressBar.create title: title, total: nil
  num.times do
    yield
    #progress.increment
  end
  #rogress.finish
end

execute_with_progress(MODEL_COUNTS[:user], "Users"){ FactoryGirl.create(:user) }
execute_with_progress(MODEL_COUNTS[:show], "Shows"){ FactoryGirl.create(:show) }
execute_with_progress(MODEL_COUNTS[:performer], "Performers"){ FactoryGirl.create(:performer, :with_shows) }
execute_with_progress(MODEL_COUNTS[:review], "Reviews"){ FactoryGirl.create(:review) }

