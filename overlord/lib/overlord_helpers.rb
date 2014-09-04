module OverlordHelpers
  def keypad_last_row
    values = []
    values << {value: 'C', class: 'btn-danger glyphicon glyphicon-remove'}
    values << {value: '0', class: 'btn-info'}
    values << {value: 'S', class: 'btn-success glyphicon glyphicon-ok'}
  end

  def keypad_control_row
    values = []
    values << {value: 'Deactivate', class: 'btn-danger'}
    values << {value: 'Activate', class: 'btn-success'}
    values
  end

  def keypad_numbers
    values = []
    keypadrow = []
    for value in 1...4 do
      keypadrow << {value: value.to_s, class: 'btn-info'}
    end
    values << keypadrow
    keypadrow = []
    for value in 4...7 do
      keypadrow << {value: value.to_s, class: 'btn-info'}
    end
    values << keypadrow
    keypadrow = []
    for value in 7...10 do
      keypadrow << {value: value.to_s, class: 'btn-info'}
    end
    values << keypadrow
    keypadrow = []
    values
  end

# we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  def is_i?(code)
    !!(code =~ /\A[-+]?[0-9]+\z/)
  end

  def is_code_set?(code)
    !session[code].nil?
  end

  def is_code_long_enough?(code, value)
    if value.to_s.length < 4
      json :errors => "#{code.to_s}:'not long enough'"
      false
    else
      true
    end
  end

  def detonation_time
    det = TimeDifference.between(session[:request_time], session[:detonationCode]).in_general
    sprintf('%02d%02d%02d', det[:hours], det[:minutes], det[:seconds])
  end

  def bomb_time(h, m, s)
    request_time = Time.current
    session[:request_time] = request_time
    request_time+ h.hours + m.minutes + s.seconds
    # [detonate.hour - current.hour, detonate.min - current.min, detonate.sec - current.sec]
  end

  def check_or_set_code(code, value, type: nil)
    if is_code_set?(code) && session[code] == value
      'code already set'
      # json :errors => 'code already set'
    else
      if is_code_long_enough?(code, value) && type.nil?
        session[code] = value
      else
        bomb_detonation = bomb_time(*sprintf("%06d", value).scan(/../).map(&:to_i))
        session[code] = bomb_detonation
      end
      nil
    end
  end

  def is_codeset?(sesh, code)
    if !sesh[code].nil?
      json :status => 'code already set'
      json :body => code.to_s
      halt 302
    end
  end
end
