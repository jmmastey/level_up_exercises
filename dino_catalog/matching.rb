
def Match(object, field, matches)
  value = object.send(field) if field != nil

  matches.each do |key,proc|
    if field != nil
      return proc.call(object) if key == value
    else 
      return proc.call if key == object
    end
  end
  raise "Invalid match!: #{value} was not found in hash!"
end
