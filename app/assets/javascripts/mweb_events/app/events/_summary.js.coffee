$ ->

  renderMap = ->
    # if coordinates have not been rendered, exit and do nothing
    return unless $('.event-map').length

    lat = $('.event-map').attr('data-latitude')
    long = $('.event-map').attr('data-longitude')
    zoom = $('.event-map').attr('data-zoom')
    addr = $('.event-map').attr('data-address')
    attrib = $('.event-map').attr('data-attribution')
    layerCode = $('.event-map').attr('data-layer')

    map = L.map('map').setView([lat, long], zoom)

    layer = L.tileLayer layerCode,
      attribution: attrib,
      maxZoom: zoom

    marker = L.marker([lat, long]).addTo(map)
    marker.bindPopup(addr).openPopup

    layer.addTo(map)

  if MwebEvents.isOnPage 'mweb_events-events', 'show'
    renderMap()

#    = map(:center => { :latlng => latlng, :zoom => 15 }, :markers => [{ :latlng => latlng, :popup => @event.address}])
