class DinosaurCollectionPrinter
  def initialize(collection)
    @dinos = collection
  end

  def prepare_view
    output = prepare_header
    @dinos.each do |dino|
      output = prepare_row(dino, output)
      output = prepare_delimiter(output)
    end
    output
  end

  def prepare_row(dino, output)
    dino.to_h.each do |key, value|
      output += "#{key}: #{value}\n" unless value.nil?
    end
    output
  end

  def prepare_delimiter(output)
    output + ("_") * 40 + "\n"
  end

  def prepare_header
    "results:\n"
  end

  private :prepare_header, :prepare_row, :prepare_delimiter
end
