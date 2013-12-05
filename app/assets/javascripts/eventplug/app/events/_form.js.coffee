$ ->
  if isOnPage 'eventplug-events', 'edit' or isOnPage 'eventplug-events', 'new'
    $("#event_date").datepicker()

    opts =
      button: false

    editor = new EpicEditor(opts).load()

    editor.on 'save', ->
      $('#event_description').val(editor.exportFile())
