class AddLatitudeAndLongitudeToEventplugEvent < ActiveRecord::Migration
  def change
    add_column :eventplug_events, :latitude, :float
    add_column :eventplug_events, :longitude, :float
  end
end
