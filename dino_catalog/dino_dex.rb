require './dino'
require './dino_dex_search'

class DinoDex

  def initialize(*files)

    @dex_array = []

    if files.nil? || files.size == 0
      raise 'We have no files to initialize our Dino Dex!'
    else
      files.each do |file|
        process_file(file)
      end
    end

  end


  def filter
    DinoDexSearch.new(@dex_array)
  end


  def process_file(file_name)
    File.open(file_name, "r") do |source_file|

      input_enum = source_file.each

      header = input_enum.next

      column_details = process_header(header)

      input_enum.each do |row|
        dino_details = process_row(row)
        dino_hash = process_dino(dino_details, column_details)
        @dex_array << Dino.new(dino_hash)
      end

    end
  end

  def process_row(row)

    items = row.split(',')

    items = items.map do |i|
      i.gsub(/\s\z/,"")
    end

    return items

  end

  def process_dino(dino_details, column_details)
    # nil defautl used in Dino initialize
    dino_hash = Hash.new(nil)

    column_details.each_with_index do |key, index|
      if key == :special_diet_carnivore
        if(dino_details[index] == "Yes")
          dino_hash[:diet] = "Carnivore"
        else
          # Leave this field nil?
          dino_hash[:diet] = nil
        end
      else
        dino_hash[key] = dino_details[index]
      end
    end

    dino_hash

  end

  def process_header(header)
    columns = header.split(',')

    columns = columns.map do |h|
      h.gsub(/\s+/,"")
    end

    columns = columns.map(&:downcase)

    columns.map do |h|
      Dino.get_symbol_key(h)
    end

  end

  private :process_file, :process_header

end
