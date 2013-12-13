$ ->

  if isOnPage('eventplug-events', 'new') or isOnPage('eventplug-events', 'edit')

    $("#event_date").datepicker()

    opts =
      button: false
      file:
        name: 'epiceditor',
        defaultContent: $('#event_description').text(),
        autoSave: 1000
      autogrow:
        scroll: true

    editor = new EpicEditor(opts).load()

    editor.on 'save', ->
      $('#event_description').val(editor.exportFile())
