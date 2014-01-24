$ ->
  if MwebEvents.isOnPage('mweb_events-events', 'new') or MwebEvents.isOnPage('mweb_events-events', 'edit') or MwebEvents.isOnPage('mweb_events-events', 'create')

    # Calendar
    $('#start_on, #end_on').datetimepicker
      language: 'pt-BR'

    # Kind of a hack to show the arrows
    $('#start_on i, #end_on i').on 'click', (e) ->
      $('.icon-chevron-down').attr('class', 'icon icon-chevron-down')
      $('.icon-chevron-up').attr('class', 'icon icon-chevron-up')

    # Time zone
    $("#event_time_zone").select2()

    # Location
    if $("#event_location")[0].value is ""
        $("#event_address").attr('disabled', true)

    enable_address = ->
      if @value isnt ""
        $("#event_address").removeAttr("disabled")
      else
        $("#event_address").attr("disabled", true)

    $("#event_location").on 'input keyup', enable_address

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
