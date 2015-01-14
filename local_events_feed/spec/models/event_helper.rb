def time(day, hour)
  formatted = sprintf("201410%02dT%02d0000", day, hour)
  DateTime.parse(formatted)
end

def create_events
  [
    create(:event, name: "A"),
    create(:event, name: "B"),
    create(:event, name: "C"),
  ]
end

def create_events_with_showings
  [
    create(:event, name: "A", times: [ten_oclock, nine_oclock, eight_oclock]),
    create(:event, name: "B", times: [eight_oclock]),
    create(:event, name: "C", times: [nine_oclock, ten_oclock]),
  ]
end

def eight_oclock
  DateTime.parse("20141001T080000")
end

def nine_oclock
  DateTime.parse("20141001T090000")
end

def ten_oclock
  DateTime.parse("20141001T100000")
end
