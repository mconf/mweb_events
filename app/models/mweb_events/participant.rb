module MwebEvents
  class Participant < ActiveRecord::Base
    attr_accessible :email, :event, :owner

    belongs_to :owner, :polymorphic => true
    belongs_to :event

  end
end
