def category(*args)
  return { "cohort" => args[0], "result" => args[1] } if args.length > 1
  { "cohort" => args[0] }
end
