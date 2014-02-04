module MwebEvents
  class Participant < ActiveRecord::Base
    attr_accessible :email, :event, :event_id, :owner, :owner_id

    belongs_to :owner, :polymorphic => true
    belongs_to :event

    validates :event_id, :presence => true
    validates :email, :presence => true, :uniqueness => { :scope => :event_id }
    validates :owner_id, :presence => true, :uniqueness => { :scope => :event_id }

  end
end
