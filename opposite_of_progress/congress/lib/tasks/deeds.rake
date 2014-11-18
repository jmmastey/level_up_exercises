desc "Creates good deeds"
task :deeds => [:environment, :law_voted_on, :enacted_into_law]

desc "Deeds for bills voted on recently"
task :law_voted_on do
  DeedsHelper::law_voted_on
end

desc "Deeds for bills enacted into law recently"
task :enacted_into_law do
  DeedsHelper::enacted_into_law
end