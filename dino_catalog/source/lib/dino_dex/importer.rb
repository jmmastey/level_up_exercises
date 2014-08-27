require "CSV"

class Importer
  OPTIONS = {
    :converters => [:nullify, :numeric, :reformat],
    :headers => :first_row,
    :header_converters => [:translate]
  }

  TRANSLATIONS = {
    :genus => [:name, :genus],
    :period => [:period],
    :continent => [:continent],
    :diet => [:carnivore, :diet],
    :weight => [:weight, :weight_in_lbs],
    :locomotion_type => [:walking],
    :description => [:description]
  }

  TRANSLATION_MATRIX = TRANSLATIONS.inject({}){|h, (k,v)| v.map{|f| h[f] = k}; h} # invert for array values

  CSV::Converters[:nullify] = lambda do |value, info|
    value.try(:empty?) ? nil : value
  end

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

  CSV::HeaderConverters[:translate] = lambda do |value, info|
    value = Importer.normalize(value)
    Importer.translate(value)
  end

  def initialize; end

  def self.load(file_path, entry_klass, entries = [])
    CSV.read(file_path, OPTIONS).each do |row|
      entries << entry_klass.new(**Hash[row.headers.zip(row.fields)])
    end
    entries
  end

  def self.translate(value)
    TRANSLATION_MATRIX[value] || value
  end

  def self.normalize(value)
    value.to_s.snake_case.downcase.to_sym
  end
end