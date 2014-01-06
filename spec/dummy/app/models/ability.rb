class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can :index, Eventplug::Event
    can :manage, Eventplug::Event, :owner_id => user.id

  end
end
