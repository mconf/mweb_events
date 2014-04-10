$ ->
  if MwebEvents.isOnPage('mweb_events-events', 'new') or MwebEvents.isOnPage('mweb_events-events', 'edit') or MwebEvents.isOnPage('mweb_events-events', 'update')

    # Calendar
    $('#start_on_date, #end_on_date').datetimepicker
      language: 'pt-BR' # TODO: use the user's language
      pickTime: false

    $('#start_on_time, #end_on_time').datetimepicker
      language: 'pt-BR'
      pickDate: false

    # Hacky way to open the field when clicking the input

    # Show the ok button
    $('.datepicker-field, .add-on i').on 'click', (e) ->
      $('.add-on i', this).click()

      if $('.bootstrap-datetimepicker-widget a.btn.ok').length == 0
        $('.bootstrap-datetimepicker-widget').append('<a class="btn ok btn-primary">Ok</a>')

        $('.bootstrap-datetimepicker-widget a.ok').click ->
          $('.bootstrap-datetimepicker-widget').hide()

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
