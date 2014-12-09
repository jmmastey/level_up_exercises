class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Watch do |watch|
      watch_user = watch.try(:user_id)
      user.present? && (watch_user.nil? || watch_user == user.id)
    end
  end
end
