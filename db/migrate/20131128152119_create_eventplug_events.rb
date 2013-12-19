class CreateEventplugEvents < ActiveRecord::Migration
  def change
    create_table :eventplug_events do |t|
      t.string :name
      t.date :start_on
      t.date :end_on
      t.string :location
      t.string :address
      t.text :description
      t.references :owner, :polymorphic => {:default => 'User'}

      t.timestamps
    end
  end
end
