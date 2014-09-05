
def OldMatch(val_or_proc, matches, *args)
  if val_or_proc.is_a? Proc or val_or_proc.is_a? Method
    match_proc(val_or_proc, matches, *args)
  else
    match_val(val_or_proc, matches)
  end
end

def Match(value, matches)
  methods.each do |method|
    match_equality(value, matches) {|match| return value_of(match) }
    match_regular_exp(value, matches) {|match| return value_of(match) }
    match_instance_of(value, matches) {|match| return value_of(match) }
  end
  raise "No match found for #{value}!"
end

private
def match_equality(value, matches)
  matches.each do |key, match|
   return nil if not value.respond_to?(:==)
   yield match if value == key
  end
end

def match_instance_of(value, matches)
  matches.each do |key, match|
    return nil if not value.respond_to?(:is_a?)
    yield match if key.is_a?(Class) and value.is_a?(key)
  end
end

def match_regular_exp(value, matches)
  matches.each do |key, match|
    return nil if not value.respond_to?(:=~)
    yield match if value =~ key
  end
end

def match_proc(match_proc, matches, *args)
  matches.each do |key, proc_or_val|
    return value_of(proc_or_val) if match_proc.call(*args + [key]) == true
  end
  raise "Unmatched!: function never evaluates to true!"
end

def match_val(match_key, matches)
  proc_or_val = matches[match_key]
  return value_of(proc_or_val) if proc_or_val != nil
  raise "Unmatched!: no #{match_key} in matches!"
end

def value_of(proc_or_val)
  if proc_or_val.is_a? Proc or proc_or_val.is_a? Method
    proc_or_val.call
  else
    proc_or_val
  end
end
