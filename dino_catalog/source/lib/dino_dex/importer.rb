require 'csv'
require_relative 'configuration.rb'

class Importer
  OPTIONS = {
    converters: [:instantiate, :numeric, :transform],
    headers: :first_row,
    header_converters: [:transform]
  }

  def self.import(file_path, entry_klass, entries = [])
    data = load(file_path)
    config = data[:configuration]
    data[:table].each.inject(entries) do |a, e|
      entry = include_missing(config, Hash[e.headers.zip(e.fields)])
      a << entry_klass.new(**entry)
    end
  end

  def self.load(file_path)
    config = Configuration.new("#{file_path}.yml")
    setup_converters(config)
    {
      configuration: config,
      table: CSV.read(file_path, OPTIONS)
    }
  end

  def self.include_missing(config, entry_hash)
    missing_fields = config.raw[:fields].keys - entry_hash.keys
    missing_fields.inject(entry_hash) do |a, e|
      a << { e => config.raw[:fields][e].try(:default_value) }
    end
  end

  def self.setup_converters(config)
    setup_field_converters(config)
    setup_header_converters(config)
  end

  def self.setup_field_converters(config)
    setup_instantiate_converter(config)
    setup_transform_converter(config)
  end

  def self.setup_instantiate_converter(config)
    CSV::Converters[:instantiate] = lambda do |value, info|
      value = value.try(:empty?) ? nil : value
      config.default_value(info.header) || value
    end
  end

  def self.setup_transform_converter(config)
    locale = config.lexicon
    formatters = config.field_formatters
    CSV::Converters[:transform] = lambda do |value, info|
      unless value.nil?
        type = config.value_type(info.header)
        value = Configuration.normalize_value(type, value)
        value = format_field(formatters, info.header, value)
        lex(locale, info.header, value)
      end
    end
  end

  def self.setup_header_converters(config)
    locale = config.translations
    formatters = config.header_formatters
    CSV::HeaderConverters[:transform] = lambda do |value|
      value = Configuration.normalize_value(:symbol, value)
      value = format_header(formatters, value)
      translate(locale, value)
    end
  end

  def self.format_field(formatters, field, value)
    if formatters.try(field)
      formatters[field].inject(value) { |a, e| a.try(e) || a }
    else
      value
    end
  end

  def self.format_header(formatters, field)
    if formatters.try(field)
      formatters[field].inject(field) { |a, e| a.try(e) || a }
    else
      field
    end
  end

  def self.translate(locale, value)
    locale[value] || value
  end

  def self.lex(locale, field, value)
    locale.try(field).try(value) || value
  end
end
