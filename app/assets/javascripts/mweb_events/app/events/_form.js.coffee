$ ->
  if MwebEvents.isOnPage('mweb_events-events', 'new') or MwebEvents.isOnPage('mweb_events-events', 'edit') or MwebEvents.isOnPage('mweb_events-events', 'update')

    # Calendar
    $('#start_on_date, #end_on_date').datetimepicker
      language: 'pt-BR' # TODO: use the user's language
      showToday: true
      pickTime: false

    $('#start_on_time, #end_on_time').datetimepicker
      language: 'pt-BR'
      pickDate: false
      minuteStepping: 10
      icons:
        up: "icon icon-chevron-up",
        down: "icon icon-chevron-down"

    # Make respective buttons clear their fields
    $('.clear-date').on 'click', (e) ->
      $('#event_' + $(this).attr('data-clear')).val('')

    # Time zone
    $("#event_time_zone").select2()

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
