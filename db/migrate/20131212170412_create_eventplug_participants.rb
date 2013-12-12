class CreateEventplugParticipants < ActiveRecord::Migration
  def change
    create_table :eventplug_participants do |t|
      t.references :owner, :polymorphic => {:default => 'User'}
      t.references :event
      t.string :email

      t.timestamps
    end
  end
end
