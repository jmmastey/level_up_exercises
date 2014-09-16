module OverlordHelpers
  def keypad_last_row
    values = []
    values << { value: 'C', class: 'btn-danger glyphicon glyphicon-remove' }
    values << { value: '0', class: 'btn-info' }
    values << { value: 'S', class: 'btn-success glyphicon glyphicon-ok' }
  end

  def keypad_control_row
    values = []
    values << { value: 'Deactivate', class: 'btn-danger' }
    values << { value: 'Activate', class: 'btn-success' }
    values
  end

  def keypad_numbers
    values = []
    keypadrow = []
    (1...4).each do |value|
      keypadrow << { value: value.to_s, class: 'btn-info' }
    end
    values << keypadrow
    keypadrow = []
    (4...7).each do |value|
      keypadrow << { value: value.to_s, class: 'btn-info' }
    end
    values << keypadrow
    keypadrow = []
    (7...10).each do |value|
      keypadrow << { value: value.to_s, class: 'btn-info' }
    end
    values << keypadrow
    values
  end

  # we can shove stuff into the session cookie YAY!
  def start_time
    session[:start_time] ||= (Time.now).to_s
  end

  def i?(code)
    !!(code =~ /\A[-+]?[0-9]+\z/)
  end

  def code_set?(code)
    !session[code].nil?
  end

  def code_long_enough?(code, value)
    if value.to_s.length < 4
      json errors: "#{code}:'not long enough'"
      false
    else
      true
    end
  end

  def detonation_time
    det = TimeDifference.between(session[:request_time],
                                 session[:detonationCode]).in_general
    sprintf('%02d%02d%02d', det[:hours], det[:minutes], det[:seconds])
  end

  def bomb_time(h, m, s)
    request_time = Time.current
    session[:request_time] = request_time
    request_time + h.hours + m.minutes + s.seconds
  end

  def check_or_set_code(code, value, type: nil)
    if code_set?(code) && session[code] == value
      'code already set'
    else
      if code_long_enough?(code, value) && type.nil?
        session[code] = value
      else
        bomb_detonation = bomb_time(*sprintf('%06d',
                                             value).scan(/../).map(&:to_i))
        session[code] = bomb_detonation
      end
      nil
    end
  end

  def codeset?(sesh, code)
    unless sesh[code].nil?
      json status: 'code already set'
      json body: code.to_s
      halt 302
    end
  end
end
