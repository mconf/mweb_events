class CreateEventplugParticipants < ActiveRecord::Migration
  def change
    create_table :eventplug_participants do |t|
      t.references :owner, :polymorphic => true
      t.references :event
      t.string :email

      t.timestamps
    end
  end
end
