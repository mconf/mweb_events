class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can :index, MwebEvents::Event
    can :manage, MwebEvents::Event, :owner_id => user.id

  end
end
