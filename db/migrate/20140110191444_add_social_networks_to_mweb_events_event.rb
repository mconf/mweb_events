class AddSocialNetworksToMwebEventsEvent < ActiveRecord::Migration
  def change
    add_column :mweb_events_events, :social_networks, :string
  end
end
