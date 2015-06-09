class InputParser
  def parse(input)
    words = input.split(' ')
    [words.shift, words.join(' ')]
  end

  def parse_cmd(input)
    parse(input)[0]
  end

  def parse_options(input)
    parse(input)[1]
  end

  def extract_flags(flags)
    flags_param(flags) + flags_hash(flags) + flags_standalone(flags)
  end

  private

  def flags_param(flags)
    match_extract(flags, /-\w\??\s[^-{]+/)
  end

  def flags_hash(flags)
    match_extract(flags, /-\w\s{[^}]+}/)
  end

  def flags_standalone(flags)
    flags = match_extract(flags, /-\w\s?(?=-|$)/)
    flags.map { |flag| [flag[0]] }.uniq
  end

  def match_extract(str, regx)
    str.scan(regx).map do |match|
      match_arr = match.split(' ')
      [match_arr.shift, match_arr.join(' ')]
    end
  end
end
