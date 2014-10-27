class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Watch, user_id: user.id
  end
end
