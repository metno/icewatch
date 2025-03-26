# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'ready turbolinks:load', ->
  crs = new L.Proj.CRS('EPSG:3995',
  "+proj=stere +lat_0=90 +lat_ts=71 +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs",
  {
    origin: [0, 0], 
    resolutions: [22600, 11300, 5650, 2825, 1412.5, 706.25, 353.125, 176.5625, 88.28125, 44.140625],
    tileSize: 256,
    bounds: L.bounds([-3400000, 3400000, 3400000,-3400000])
  })

  return if $('#map').length == 0

  map = new L.Map 'map',
  	crs: crs,
  	continuousWorld: true,

  map.setView [90, 90], 2 

  L.tileLayer.wms('https://view.eumetsat.int/geoserver/wms', {
    layers: 'backgrounds:ne_background'
    format: 'image/png'
    transparent: true
    continuousWorld: true
    attributution: '<a href="https://view.eumetsat.int">EUMETSAT</a>'
  }).addTo(map)

  cruiseLayer = L.featureGroup().addTo(map)

  $("#map > layer").each (index, layer) ->
    url = $(layer).data('url')
    $.getJSON url, (data) =>
      layer = L.geoJson(data,
        pointToLayer: (feature, latlng) ->
          markerOptions =
            radius: feature.properties.iceConcentration
            className: "#{feature.properties.dominantIceType}-ice"
            color: '#000'
            fillOpacity: 1
          L.circleMarker(latlng, markerOptions)
      )
      cruiseLayer.addLayer(layer)
      # zooms to data 
      # commented out to stop multiple zooms when loading many datasets
      #map.fitBounds(cruiseLayer.getBounds())

$(document).on 'change.bs.fileinput', '.cruise-upload', (event) ->
  $(this).find('input[type=file]').parse
    config:
      header: true
      skipEmptyLines: true
      dynamicTypeing: true
      complete: (results) =>
        url = $(this).find('input[type=file]').data('submit-url')
        uploader = new ObsUploader url, results.data
        #uploader.submitNextRow()
        $(this).fileinput('clear')

$(document).on 'click', '#all-export', ->
  $(".export[type='checkbox']").prop("checked", true)
$(document).on 'click', '#none-export', ->
  $(".export[type='checkbox']").prop("checked", false)

$(document).on 'click', '.selected-export', (e) ->
  e.preventDefault()

  params = ""
  $(".export[type='checkbox']:checked").each (index, item) ->
    params += "&" unless index is 0
    params += "observations[]=#{$(item).val()}"
  params = "observations[]=#{null}" if params is ""

  joiner = if $(this).attr('href').indexOf('?') is -1 then "?" else "&"
  document.location = "#{$(this).attr('href')}#{joiner}#{params}"

$(document).on 'click', '#sigrid-data-submit', (e) ->
  e.preventDefault()
  $("#sigrid-form").submit()
