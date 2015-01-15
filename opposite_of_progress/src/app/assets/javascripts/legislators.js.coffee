# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

generateSlug = (value)->
  value.toLowerCase().replace(/-+/g, '').replace(/\s+/g, '-').replace(/[^a-z0-9-]/g, '')


$(document).on 'change', '#state-select', ->
  $select = $(this)
  $selected = $select.find('option:selected')
  selectedVal = $selected.val()
  location = '/legislators'

  if selectedVal != ''
    location += "/" + generateSlug(selectedVal)

  window.location = location
