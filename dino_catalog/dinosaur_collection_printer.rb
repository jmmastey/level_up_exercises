class DinosaurCollectionPrinter
  def print_row(dino, output)
    dino.facts_hash.each do |key, value|
      output += "#{key}: #{value}\n" unless value.nil?
    end
    output
  end

  def print_delimiter(output)
    output + ("_")*40+"\n"
  end

  def print_header
    "results:\n"
  end
end
