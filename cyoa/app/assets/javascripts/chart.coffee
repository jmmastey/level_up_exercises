$ ->
  LEFT_USER_COLOR = '#79bd9a'
  RIGHT_USER_COLOR = '#3b8686'
  STATS = [ 'keys', 'clicks', 'download', 'upload', 'uptime' ]

  $('#users_form').submit ->
    NProgress.start()

    moveQueryContainerToTop()
    resetCanvases()

    submitAPIRequest(requestComplete)

  moveQueryContainerToTop = () ->
    $('.query-container').addClass('query-container-top')

  resetCanvases = () ->
    $.each $('canvas'), (index, canvas) ->
      $(canvas).attr('height', 400)
      $(canvas).attr('width', 400)

  submitAPIRequest = (completionCallback) ->
    user1 = $('#user1').val()
    user2 = $('#user2').val()
    route = '/poll?user1='+user1+'&user2='+user2

    $.get route, completionCallback

  requestComplete = (results) ->
    NProgress.done()

    setBothUserDetails($('#user1').val(), $('#user2').val(), results)
    setChartData(results)

    fadeInUserDetailsAndChart()
    delayedFadeInChartLabels()

  fadeInUserDetailsAndChart = () ->
      $('.user-info').fadeIn()
      $('.charts-container').fadeIn()
      $('.chart-label').fadeIn()

  delayedFadeInChartLabels = () ->
    showAndArcChartLabels = () ->
      $('.chart-data-label').fadeIn()
      $('.arc_down').arctext({radius:120, dir:1})
      $('.arc_up').arctext({radius:120, dir:-1})

    setTimeout showAndArcChartLabels, 2000

  setBothUserDetails = (user1, user2, results) ->
    resetFlags()
    setUserDetails(user1, results[0], 'left')
    setUserDetails(user2, results[1], 'right')

  resetFlags = () ->
    $('.flag-left').removeClass().addClass('flag-left flag')
    $('.flag-right').removeClass().addClass('flag-right flag')

  setUserDetails = (userName, userData, column) ->
    setUserData(userName, userData['country'], column)
    setTeamData(userData['team'], column)

  setChartData = (results) ->
    for stat in STATS
      chart = $(getChartIdCss(stat)).get(0).getContext("2d")
      new Chart(chart).Doughnut(parseAttribute(results, stat))
      resetLabels(stat)
      setAndAlignLabels(results, stat, getLabelLeftCss(stat), getLabelRightCss(stat))

  setUserData = (userName, country, column) ->
    $('.user-name-'+column).html(userName)
    $('.flag-'+column).addClass('flag-'+country.toLowerCase())

  setTeamData = (userTeamData, column) ->
    $('.team-name-'+column).html(userTeamData['name'])

    for stat in STATS
      $(getTeamStatCss(stat, column)).html(commaify(userTeamData[stat]))

  resetLabels = (stat) ->
    baseClasses = 'chart-data-label display-none '
    $(getLabelLeftCss(stat)).removeClass().addClass(baseClasses+stat+'-left')
    $(getLabelRightCss(stat)).removeClass().addClass(baseClasses+stat+'-right')

  getTeamStatCss = (stat, column) ->
    '.team-'+stat+'-'+column

  getChartIdCss = (stat) ->
    '#'+stat+'-chart'

  getLabelLeftCss = (stat) ->
    '.'+stat+'-left'

  getLabelRightCss = (stat) ->
    '.'+stat+'-right'

  parseAttribute = (results, resultKey) ->
      [ { value: parseInt(results[1][resultKey]), color: LEFT_USER_COLOR },\
        { value: parseInt(results[0][resultKey]), color: RIGHT_USER_COLOR }]

  setAndAlignLabels = (results, resultKey, labelLeft, labelRight) ->
    user2Stat = parseInt(results[1][resultKey])
    user1Stat = parseInt(results[0][resultKey])
    user2Angle = parseInt(user2Stat/(user2Stat+user1Stat)*360/2)
    user1Angle = parseInt(user1Stat/(user2Stat+user1Stat)*360/2)+(user2Angle*2)

    setLabelValues(labelLeft, labelRight, user1Stat, user2Stat)
    setLabelRotationCss(labelLeft, labelRight, user1Angle, user2Angle)
    setLabelArcCss(labelLeft, labelRight, user1Angle, user2Angle)

  setLabelValues = (labelLeft, labelRight, user1Stat, user2Stat) ->
    $(labelLeft).html(commaify(user1Stat))
    $(labelRight).html(commaify(user2Stat))

  setLabelRotationCss = (labelLeft, labelRight, user1Angle, user2Angle) ->
    $(labelLeft).addClass(cssRotationClass(user1Angle))
    $(labelRight).addClass(cssRotationClass(user2Angle))

  setLabelArcCss = (labelLeft, labelRight, user1Angle, user2Angle) ->
    $(labelLeft).addClass(calculateArcDirection(user1Angle))
    $(labelRight).addClass(calculateArcDirection(user2Angle))

  cssRotationClass = (rotationAngle) ->
    'deg'+rotationAngle

  calculateArcDirection = (rotationAngle) ->
    if rotationAngle > 90 and rotationAngle < 270
      'arc_up'
    else
      'arc_down'

  commaify = (number) ->
    number = number.toString().replace(/(\d+)(\d{3})/, '$1'+','+'$2')\
      while /(\d+)(\d{3})/.test(number.toString())
    number
