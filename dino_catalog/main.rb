PROJECT_ROOT ||= File.dirname(__FILE__)
%W(#{PROJECT_ROOT} #{PROJECT_ROOT}/lib).each do |i|
  $LOAD_PATH.unshift(i) unless $LOAD_PATH.include?(i)
end

Dir["#{PROJECT_ROOT}/lib/**/**.rb"].each { |f| load f }

