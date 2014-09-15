class Else
end

def OldMatch(val_or_proc, matches, *args)
  if val_or_proc.is_a?(Proc) || val_or_proc.is_a?(Method)
    match_proc(val_or_proc, matches, *args)
  else
    match_val(val_or_proc, matches)
  end
end

def Match(value, matches)
  match_equality(value, matches) { |match| return value_of(match) }
  match_regular_exp(value, matches) { |match| return value_of(match) }
  match_instance_of(value, matches) { |match| return value_of(match) }
  if matches[Else].nil?
    fail "No match found for #{value}!"
  else
    value_of(matches[Else])
  end
end

private

def match_equality(value, matches)
  match = matches[value]
  yield match unless match.nil?
end

def match_instance_of(value, matches)
  return nil unless value.respond_to?(:is_a?)
  matches.each do |key, match|
    yield match if key.is_a?(Class) && value.is_a?(key)
  end
end

def match_regular_exp(value, matches)
  return nil unless value.respond_to?(:=~)
  matches.each do |key, match|
    yield match if key.is_a?(Regexp) && (value =~ key)
  end
end

def match_proc(match_proc, matches, *args)
  matches.each do |key, proc_or_val|
    return value_of(proc_or_val) if match_proc.call(*args + [key]) == true
  end
  fail "Unmatched!: function never evaluates to true!"
end

def match_val(match_key, matches)
  proc_or_val = matches[match_key]
  fail "Unmatched!: no #{match_key} in matches!" if proc_or_val.nil?
  value_of(proc_or_val)
end

def value_of(proc_or_val)
  if proc_or_val.is_a?(Proc) || proc_or_val.is_a?(Method)
    proc_or_val.call
  else
    proc_or_val
  end
end
