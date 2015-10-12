class Dinobase
  attr_reader :dinosaurs
  @debug = true
  
  def initialize(_args = {})
    @dinosaurs = []
    @debug = false
  end

  def open_and_read_file(file_path)
    file = File.open(file_path, "r")
    data = file.read
    file.close
    data
  end

  def if_not_number_then_not_avail(potential_number)
    (potential_number =~ /\A[-+]?\d+\z/) ? potential_number : 'N/A'
  end

  def new_entry_for_dinodex_row(row)
    cells = row.split(',')

    new_entry = {}
    new_entry['name'] = cells[0]
    new_entry['period'] = cells[1]
    new_entry['continent'] = cells[2]
    new_entry['diet'] = cells[3]
    new_entry['weight'] = if_not_number_then_not_avail(cells[4])
    new_entry['walking'] = cells[5]
    new_entry['description'] = cells[6]

    new_entry
  end

  def parse_dinodex
    csv_path = './dinodex.csv'
    csv_content = open_and_read_file(csv_path)
    line_count = 0
    skipped_first_line = false
    csv_content.each_line do |row|
      # skip the header.
      if skipped_first_line == false
        skipped_first_line = true
        next
      end
      new_entry = new_entry_for_dinodex_row(row)

      @dinosaurs.push(new_entry)
      line_count += 1
    end
    print "Just loaded " + line_count.to_s +
      " Dinosaurs from dinodex\n" if @debug
  end

  def new_entry_for_african_dinos_row(row)
    cells = row.split(',')

    new_entry = {}
    new_entry['name'] = cells[0]
    new_entry['period'] = cells[1]
    new_entry['continent'] = 'N/A'
    new_entry['diet'] = cells[2] == 'Yes' ? 'Carnivore' : 'Herbivore'
    new_entry['weight'] = if_not_number_then_not_avail(cells[3])
    new_entry['walking'] = cells[4]
    new_entry['description'] =
    'Not a lot is known about ' + cells[0] + ' at this point.'

    new_entry
  end

  def parse_african_dinos
    csv_path = './african_dinosaur_export.csv'
    csv_content = open_and_read_file(csv_path)

    line_count = 0
    skipped_first_line = false
    csv_content.each_line do |row|
      # skip the header.
      if skipped_first_line == false
        skipped_first_line = true
        next
      end
      new_entry = new_entry_for_african_dinos_row(row)

      @dinosaurs.push(new_entry)
      line_count += 1
    end
    print "Just loaded " + line_count.to_s +
      " Dinosaurs from african dinosaurs\n" if @debug
  end
end