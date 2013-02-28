# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#bands').dataTable
    asStripeClasses: ['strip1', 'strip2']
    aaSorting: [[ 3, "desc" ]]
    iDisplayLength: 25
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#bands').data('source')
    aoColumnDefs: [{sClass: "hidden-phone", aTargets: [ 1, 2 ] }]
