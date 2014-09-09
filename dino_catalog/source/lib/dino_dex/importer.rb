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
    { configuration: config, table: CSV.read(file_path, OPTIONS) }
  end

  def self.include_missing(config, entry_hash)
    (config.field_keys - entry_hash.keys).inject(entry_hash) do |a, e|
      a << { e => config.default_value(e) }
    end
  end

  def self.setup_converters(config)
    setup_field_converters(config)
    setup_header_converters(config)
  end

  def self.setup_field_converters(config)
    instantiate_field_converter(config)
    transform_field_converter(config)
  end

  def self.instantiate_field_converter(config)
    CSV::Converters[:instantiate] = lambda do |value, info|
      value = value.try(:empty?) ? nil : value
      config.default_value(info.header) || value
    end
  end

  def self.transform_field_converter(config)
    locale = config.field_translations
    formatters = config.field_formatters
    CSV::Converters[:transform] = lambda do |value, info|
      unless value.nil?
        value = config.normalized_value(info.header, value)
        format_field(formatters, locale, info.header, value)
      end
    end
  end

  def self.setup_header_converters(config)
    locale = config.header_translations
    formatters = config.header_formatters
    CSV::HeaderConverters[:transform] = lambda do |value|
      value = Configuration.normalize_value(:symbol, value)
      format_header(formatters, locale, value)
    end
  end

  def self.format_value(formatters, field, value = nil)
    formatters.instance_exec(field, value || field) do |k, v|
      (try(k) || []).inject(v) { |a, e| a.try(e) || a }
    end
  end

  def self.format_field(formatters, locale, field, value)
    field = format_value(formatters, field)
    translate_field(locale, field, value)
  end

  def self.format_header(formatters, locale, field)
    field = format_value(formatters, field)
    translate_header(locale, field)
  end

  def self.translate(matrix, *keys)
    keys.inject(matrix) { |a, e| a.try(e) } || keys.last
  end

  def self.translate_field(locale, field, value)
    translate(locale, field, value)
  end

  def self.translate_header(locale, value)
    translate(locale, value)
  end
end
