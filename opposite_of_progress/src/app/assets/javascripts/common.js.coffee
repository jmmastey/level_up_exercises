# popoverBindAll = ->
#   $("[data-toggle='popover']").popover()

popoverPreventDefault = ->
  $(document).on "click", "[data-toggle='popover']", ($event) ->
    $event.preventDefault()
    console.log 'clicked'

changeActiveNavItem = ->
  path = window.location.pathname

  $('nav[role=navigation] .left a').each ->
    $nav_link = $(this)
    $parent_li = $nav_link.parent()
    linkTarget = $nav_link.attr('href')
    if (path == '/' && linkTarget == '/') || (linkTarget != '/' && path.indexOf(linkTarget) != -1)
      $parent_li.addClass('active')
    else
      $parent_li.removeClass('active')

$(document).on "page:change", ->
  # popoverBindAll()
  changeActiveNavItem()

popoverPreventDefault()
