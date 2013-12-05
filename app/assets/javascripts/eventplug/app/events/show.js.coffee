$ ->
  if isOnPage 'eventplug-events', 'show'

    opts =
      button: false
      autogrow: true

    editor = new EpicEditor(opts).load().preview()