
def Match(val_or_proc, matches, *args)
  if val_or_proc.is_a? Proc or val_or_proc.is_a? Method
    match_proc(val_or_proc, matches, *args)
  else
    match_val(val_or_proc, matches)
  end
end

private
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
