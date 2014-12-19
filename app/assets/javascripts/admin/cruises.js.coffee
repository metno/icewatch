# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(document).on 'change.bs.fileinput', '.fileinput', (event) ->
    $(this).find('input[type=file]').parse
      config:
        header: true
        skipEmptyLines: true
        dynamicTypeing: true
        complete: (results) =>
          $('#obs-upload-complete').text(JSON.stringify(results.data))
          $(this).fileinput('reset')