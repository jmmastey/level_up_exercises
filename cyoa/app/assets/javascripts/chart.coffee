$ ->
  LEFT_USER_COLOR = '#79bd9a'
  RIGHT_USER_COLOR = '#3b8686'
  statsTracked = [ 'keys', 'clicks', 'download', 'upload', 'uptime' ]

  $('#users_form').submit ->
    NProgress.start()
    moveQueryContainerToTop()
    resetCanvases()

    user1 = $('#user1').val()
    user2 = $('#user2').val()
    apiRoute = '/poll?user1='+user1+'&user2='+user2

    $.get apiRoute, (results) ->
      NProgress.done()

      resetFlags()
      setUserDetails(user1, results[0], 'left')
      setUserDetails(user2, results[1], 'right')

      $('.user-info').fadeIn()
      $('.charts-container').fadeIn()
      $('.chart-label').fadeIn()

      for statistic in statsTracked
        chart = $(getChartId(statistic)).get(0).getContext("2d")
        new Chart(chart).Doughnut(parseAttribute(results, statistic))
        resetLabels(statistic)
        setAndAlignLabels(results, statistic, getLabelLeft(statistic), getLabelRight(statistic))

      showChartDataLabels = () ->
        $('.chart-data-label').fadeIn()
        $('.arc_down').arctext({radius:120, dir:1})
        $('.arc_up').arctext({radius:120, dir:-1})

      setTimeout showChartDataLabels, 2000

  moveQueryContainerToTop = () ->
    $('.query-container').addClass('query-container-top')

  setUserDetails = (userName, userData, column) ->
    userTeamData = userData['team']
    $('.user-name-'+column).html(userName)
    $('.team-name-'+column).html(userTeamData['name'])
    $('.team-keys-'+column).html(commaify(userTeamData['keys']))
    $('.team-clicks-'+column).html(commaify(userTeamData['clicks']))
    $('.team-download-'+column).html(commaify(userTeamData['download']))
    $('.team-upload-'+column).html(commaify(userTeamData['upload']))
    $('.team-uptime-'+column).html(commaify(userTeamData['uptime']))
    $('.flag-'+column).addClass('flag-'+userData['country'].toLowerCase())

  getChartId = (statistic) ->
    '#'+statistic+'-chart'

  getLabelLeft = (statistic) ->
    '.'+statistic+'-left'

  getLabelRight = (statistic) ->
    '.'+statistic+'-right'

  parseAttribute = (results, resultKey) ->
      [ { value: parseInt(results[1][resultKey]), color: LEFT_USER_COLOR },\
        { value: parseInt(results[0][resultKey]), color: RIGHT_USER_COLOR }]

  resetCanvases = () ->
    $.each $('canvas'), (index, canvas) ->
      $(canvas).attr('height', 400)
      $(canvas).attr('width', 400)

  resetFlags = () ->
    $('.flag-left').removeClass().addClass('flag-left flag')
    $('.flag-right').removeClass().addClass('flag-right flag')

  resetLabels = (statistic) ->
    $(getLabelLeft(statistic)).removeClass().addClass('chart-data-label display-none '+statistic+'-left')
    $(getLabelRight(statistic)).removeClass().addClass('chart-data-label display-none '+statistic+'-right')

  setAndAlignLabels = (results, resultKey, labelLeft, labelRight) ->
    user2_statistic = parseInt(results[1][resultKey])
    user1_statistic = parseInt(results[0][resultKey])
    user2_rotate = parseInt(user2_statistic/(user2_statistic+user1_statistic)*360/2)
    user1_rotate = parseInt(user1_statistic/(user2_statistic+user1_statistic)*360/2)+(user2_rotate*2)

    $(labelRight).html(commaify(user2_statistic))
    $(labelLeft).html(commaify(user1_statistic))
    $(labelRight).addClass('deg'+user2_rotate)
    $(labelLeft).addClass('deg'+user1_rotate)

    if user2_rotate > 90 and user2_rotate < 270
      $(labelRight).addClass('arc_up')
    else
      $(labelRight).addClass('arc_down')

    if user1_rotate > 90 and user1_rotate < 270
      $(labelLeft).addClass('arc_up')
    else
      $(labelLeft).addClass('arc_down')

  commaify = (number) ->
    number = number.toString().replace(/(\d+)(\d{3})/, '$1'+','+'$2')\
      while /(\d+)(\d{3})/.test(number.toString())
    number
