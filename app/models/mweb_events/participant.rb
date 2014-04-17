module MwebEvents
  class Participant < ActiveRecord::Base
    attr_accessible :email, :event, :event_id, :owner, :owner_id

    belongs_to :owner, :polymorphic => true
    belongs_to :event

    validates :event_id, :presence => true
    validates :email, :presence => true, :email => true, :uniqueness => { :scope => :event_id }
    validates :owner_id, :uniqueness => { :scope => :event_id }

    def email_taken?
      found = Participant.where(:email => email, :event_id => event).first
      found && email.present? && found.email != email
    end

  end
end
