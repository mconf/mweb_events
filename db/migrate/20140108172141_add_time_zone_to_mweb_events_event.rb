class AddTimeZoneToMwebEventsEvent < ActiveRecord::Migration
  def change
    add_column :mweb_events_events, :time_zone, :string
  end
end
