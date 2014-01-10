require "mweb_events/engine"

Leaflet.tile_layer = "http://b.tile.openstreetmap.org/{z}/{x}/{y}.png"
Leaflet.attribution = "Your attribution statement"
Leaflet.max_zoom = 18

module MwebEvents
  SOCIAL_NETWORKS = ['Facebook', 'Google+', 'Twitter', 'Linkedin', 'Pinterest', 'Foursquare']
end
