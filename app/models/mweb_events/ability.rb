module MwebEvents
  class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new

      # Events
      can :read, Event
      can :create, Event
      can :select, Event

      can [:update, :destroy], Event do |e|
        e.owner == user
      end

      # Test if user is authorized to register himself in the event
      can :register, Event do |e|
        e.owner != user && Participant.where(:owner_id => user.id, :event_id => e.id).empty?
      end

      # Participants
      can :read, Participant
      can :create, Participant

      can :destroy, Participant do |p|
        user == p.owner || p.event.owner == user
      end

    end

  end
end
