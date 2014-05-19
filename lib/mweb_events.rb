require "mweb_events/engine"

Leaflet.tile_layer = "http://b.tile.openstreetmap.org/{z}/{x}/{y}.png"
Leaflet.attribution = " \u00A9 OpenStreetMap contrib. <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA 2.0</a>"
Leaflet.max_zoom = 15

module MwebEvents
  SOCIAL_NETWORKS = ['Facebook', 'Google Plus', 'Twitter', 'Linkedin']
end
