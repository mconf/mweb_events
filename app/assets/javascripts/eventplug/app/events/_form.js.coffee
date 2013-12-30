$ ->

  if isOnPage('eventplug-events', 'new') or isOnPage('eventplug-events', 'edit')

    $('#start_on, #end_on').datetimepicker
      language: 'pt-BR'

    # Kind of a hack to show the arrows
    $('#start_on i, #end_on i').on 'click', (e) ->
      $('.icon-chevron-down').attr('class', 'fa fa-chevron-down')
      $('.icon-chevron-up').attr('class', 'fa fa-chevron-up')

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
