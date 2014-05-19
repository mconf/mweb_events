$ ->
  if MwebEvents.isOnPage('mweb_events-events', 'new|create|edit|update')

    # Calendar
    $('#start_on_date, #end_on_date').datetimepicker
      language: 'pt-BR' # TODO: use the user's language
      showToday: true
      pickTime: false

    # Make respective buttons clear their fields
    $('.clear-date').on 'click', (e) ->
      targets = $(this).attr('data-clear').split(",")
      targets.forEach (target) ->
        $("#event_#{target.trim()}").val('')
        $("#event_#{target.trim()}_#{n}i").val('') for n in [1..5]

    # Time zone
    $("#event_time_zone").select2
      width: "50%"

    # Description editor box
    opts =
      button: false
      autogrow:
        minHeight: 150
        maxHeight: 300
      button:
        preview: true
        fullscreen: false
        bar: true

    editor = new EpicEditor(opts).load()
    editor.importFile('epiceditor', $('#event_description').text())

    $("#event_description").hide()

    editor.on 'update', ->
      $('#event_description').text(editor.exportFile())

    window.onresize = ->
      editor.reflow()
