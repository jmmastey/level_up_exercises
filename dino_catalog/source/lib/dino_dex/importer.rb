require 'CSV'

class Importer
  OPTIONS = {
    converters: [:nullify, :numeric, :reformat],
    headers: :first_row,
    header_converters: [:translate]
  }

  # TODO: PASS IN VIA `load`
  # TODO: AFRICA, DUH => :continent
  TRANSLATIONS = {
    genus: [:name, :genus],
    period: [:period],
    continent: [:continent],
    diet: [:carnivore, :diet],
    weight: [:weight, :weight_in_lbs],
    locomotion_type: [:walking],
    description: [:description]
  }

  TRANSLATION_MATRIX = TRANSLATIONS.inject({}) do |hash, (key, array)|
    array.map { |word| hash[word] = key }
    hash
  end

  CSV::Converters[:nullify] = lambda do |value|
    value.try(:empty?) ? nil : value
  end

  # TODO: change to matrix, similar to TRANSLATIONS, using send with symbol arrays (to methods)
  CSV::Converters[:reformat] = lambda do |value, info|
    unless value.nil?
      case info.header
      when :genus then value.downcase
      when :weight then value.to_i
      when :period, :continent, :locomotion_type then Importer.normalize(value)
      when :diet
        case value = Importer.normalize(value)
        when :no  then :herbivore
        when :yes then :carnivore
        else value
        end
      end
    end
  end

  CSV::HeaderConverters[:translate] = lambda do |value|
    value = Importer.normalize(value)
    Importer.translate(value)
  end

  def self.load(file_path, entry_klass, entries = [])
    # TODO: LOOK AT `to_a`
    CSV.read(file_path, OPTIONS).each do |row|
      entry = entry_klass.new(**Hash[row.headers.zip(row.fields)])
      entries << entry
    end
    entries
  end

  def self.translate(value)
    TRANSLATION_MATRIX[value] || value
  end

  def self.normalize(value)
    value.to_s.gsub(' ', '_').downcase.to_sym
  end
end
