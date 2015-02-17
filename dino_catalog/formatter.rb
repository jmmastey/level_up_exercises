require 'csv'

# Class Formatter will format input csv files
class Formatter
  def self.format(csvfile)
    csv = add_column(csvfile)
    row_format(csv)
  end

  def self.header_format(csvfile)
    CSV.read(csvfile, headers: true, header_converters: [:downcase,
                                                         :header_changer])
  end

  def self.file_name(csvfile)
    File.basename(csvfile, '.*')
  end

  def self.add_column(csvfile)
    header_format(csvfile).each do |row|
      if file_name(csvfile) == 'african_dinosaur_export'
        row << %w(continent Africa)
      end
      row << ['source', file_name(csvfile)]
    end
  end

  def self.row_format(csv)
    convert_diet(csv)
  end

  def self.convert_diet(csv)
    csv.each do |row|
      case
      when row['diet'] == 'Yes'
        row['diet'] = 'Carnivore'
      when row['diet'] == 'No'
        row['diet'] = 'Unknown'
      else
        row['diet']
      end
    end
  end

  CSV::HeaderConverters[:header_changer] = lambda do |h|
    case h
    when 'genus'
      'name'
    when 'carnivore'
      'diet'
    when 'weight_in_lbs'
      'weight'
    else
      h
    end
  end
end
