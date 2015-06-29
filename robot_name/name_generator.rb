class NameGenerator
  def random_name
    "#{random_char(2)}#{random_num(3)}"
  end

  private

  def random_char(value)
    ('A'..'Z').to_a.sample(value).join('')
  end

  def random_num(value)
    (0..10).to_a.sample(value).join('')
  end
end
