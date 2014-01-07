module MwebEvents
  class Participant < ActiveRecord::Base
    attr_accessible :email, :event, :event_id

    belongs_to :owner, :polymorphic => true
    belongs_to :event

    validates :email, :presence => true
    validates :event_id, :presence => true
    validates :owner, :presence => true

  end
end
