$ ->

  if isOnPage('eventplug-events', 'new') or isOnPage('eventplug-events', 'edit')
    $("#event_date").datepicker()

    opts =
      button: false

    editor = new EpicEditor(opts).load()

    editor.on 'save', ->
      $('#event_description').val(editor.exportFile())
