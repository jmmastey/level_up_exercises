class ImportLoop
  TEXT_IMPORT_PROMPT = <<-eos
[all] Use all available data files

Enter a file number (default: all):
eos

  TEXT_IMPORT_MORE_PROMPT = <<-eos

  Would you like to load another file? (Y/n)

eos

  TEXT_INVALID_SELECTION = <<-eos

Invalid selection. Please try again:

eos

  def initialize(dinodex)
    @dex = dinodex
    @sources = Dir["*.csv"]
  end

  def import_prompt
    @sources.each_with_index { |f, i| puts "[#{i}] #{f}" }
    puts TEXT_IMPORT_PROMPT
    gets.chomp
  end

  def import_more_prompt?
    return false unless @sources.count > 0
    puts TEXT_IMPORT_MORE_PROMPT
    return false if %w(no n).include?(gets.chomp.downcase)
    true
  end

  def integer_or_false(i)
    Integer(i)
  rescue
    false
  end

  def parse_index(index)
    i = integer_or_false(index)
    return i if i && i.between?(0, @sources.count)
    false
  end

  def import_all
    @sources.each { |f| @dex.import(f) }
    puts
    puts "Loaded all available data files!"
    false
  end

  def import_single(offset)
    file = @sources[offset]
    @dex.import(file)
    @sources.delete(file)
    puts "#{file} loaded!"
    import_more_prompt?
  end

  def invalid_option
    puts TEXT_INVALID_SELECTION
    true
  end

  def loop_step(index, offset)
    if offset != false
      import_single(offset)
    elsif index.downcase == "all" || index.empty?
      import_all
    else
      invalid_option
    end
  end

  def run_loop
    loop do
      index = import_prompt
      offset = parse_index(index)

      break unless loop_step(index, offset)
    end
  end
end
