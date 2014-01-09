$ ->
  if MwebEvents.isOnPage 'mweb_events-events', 'show'
    $('.event-description').expander
      slicePoint: 840,
      preserveWords: true,
      widow: 2,
      expandEffect: 'fadeIn',
      userCollapseEffect: 'fadeOut',
      #expandText: '<i class="icon-plus-sign"></i>',
      #userCollapseText: '<i class="icon-minus-sign"></i>'
