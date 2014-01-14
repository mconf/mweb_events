module MwebEvents
  class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= User.new

      # Events
      can :read, Event
      can :create, Event

      alias_action :create, :read, :update, :destroy, :to => :organize

      can [:edit, :create, :read, :update, :destroy], Event do |e|
        e.owner == user
      end

      # Test if user is authorized to register himself in the event
      can :register, Event do |e|
        e.owner != user && Participant.where(:owner_id => user.id, :event_id => e.id).empty?
      end

      # Participants
      can :read, Participant do |p|
        p.event.owner == user || p.owner == user
      end

      can :manage, Participant do |p|
        p.event.owner == user
      end

      can :create, Participant
    end

  end
end