class NameGenerator
  def generate_name
    [*1..5].inject("") do |name, i|
      i < 3 ? name << [*'A'..'Z'].sample : name << rand(10).to_s
    end
  end
end
