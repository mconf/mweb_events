module MwebEvents
  class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new

      # Events
      can :read, Event
      can :create, Event

      can :update, Event do |e|
        e.owner == user
      end

      # Participants
      cannot :read, Participant

      can :manage, Participant do |p|
        p.event.owner == user
      end

      can :create, Participant
    end

  end
end