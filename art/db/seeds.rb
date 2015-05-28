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
  #progress.finish
end

execute_with_progress(MODEL_COUNTS[:user], "Users"){ FactoryGirl.create(:user) }
execute_with_progress(MODEL_COUNTS[:show], "Shows"){ FactoryGirl.create(:show) }
execute_with_progress(MODEL_COUNTS[:performer], "Performers"){ FactoryGirl.create(:performer, :with_shows) }
execute_with_progress(MODEL_COUNTS[:review], "Reviews"){ FactoryGirl.create(:review) }

