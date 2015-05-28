class ShowRecommender

  def initialize(user = nil)
    @user = user
  end

  def recommendations
    return [] unless Review.beloved.by(@user).exists?

    cool_people(beloved_shows(@user)).inject([]) do |recommendations, user|
      recommendations += beloved_shows(user)
      (recommendations - beloved_shows(@user)).uniq
    end
  end

  private

  def beloved_shows(user)
    Show.find(Review.beloved.by(user)
          .includes(:performance)
          .pluck(:show_id)
    )
  end

  def cool_people(beloved_shows)
    Review.includes(:performance)
          .where(rating: 5, performances: {show_id: beloved_shows})
          .pluck(:user_id)
  end
end
