require 'csv'
require 'yaml'

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
    config = configuration(file_path)
    normalize_table(config)
    {
      configuration: config,
      table: CSV.read(file_path, OPTIONS)
    }
  end

  def self.include_missing(config, entry_hash)
    missing_fields = config[:fields].keys - entry_hash.keys
    missing_fields.inject(entry_hash) do |a, e|
      a << { e => config[:fields][e].try(:default_value) }
    end
  end

  def self.configuration(file_path)
    normalize_partial do
      YAML.load_file("#{file_path}.yml")
    end
  end

  # FIXME: Method has too many lines. [12/10]
  def self.normalize_partial(data = nil, &block)
    data ||= block.call
    if data.is_a?(Hash)
      data.inject({}) do |a, (k, v)|
        a << { k.to_sym => normalize_partial(v) }
      end
    elsif data.is_a?(Array)
      data.inject([]) { |a, e| a << normalize_partial(e) }
    elsif data.is_a?(String)
      normalize_value(:symbol, data)
    else
      data
    end
  end

  def self.normalize_value(type, value)
    if type == :symbol
      value.to_s.downcase.snake_case.to_sym
    elsif type == :integer
      value.to_i
    else
      value
    end
  end

  def self.normalize_table(config)
    normalize_fields(config)
    normalize_headers(config)
  end

  # FIXME: Method has too many lines. [14/10]
  def self.normalize_fields(config)
    locale = lexicon(config[:fields])
    formatters = field_formatters(config)
    CSV::Converters[:instantiate] = lambda do |value, info|
      value = value.try(:empty?) ? nil : value
      config.try(:fields).try(info.header).try(:default_value) || value
    end
    CSV::Converters[:transform] = lambda do |value, info|
      unless value.nil?
        type = value_type(config, info.header)
        value = normalize_value(type, value)
        value = format_field(formatters, info.header, value)
        lex(locale, info.header, value)
      end
    end
  end

  def self.value_type(config, field)
    config.try(:fields).try(field).try(:type) || :symbol
  end

  def self.normalize_headers(config)
    locale = translations(config[:fields])
    formatters = header_formatters(config)
    CSV::HeaderConverters[:transform] = lambda do |value|
      value = normalize_value(:symbol, value)
      value = format_header(formatters, value)
      translate(locale, value)
    end
  end

  def self.default_field_formatters(config)
    config.try(:global).try(:fields).try(:formatters) || []
  end

  def self.field_formatters(config)
    defaults = default_field_formatters(config)
    config[:fields].inject({}) do |hash, (field, opts)|
      if opts.is_a?(Hash) && opts.try(:formatters)
        hash << { field => (opts[:formatters] + defaults) }
      else
        hash << { field => defaults }
      end
    end
  end

  def self.default_header_formatters(config)
    defaults = config.try(:global).try(:headers).try(:formatters) || []
    defaults << :to_sym
  end

  def self.header_formatters(config)
    defaults = default_header_formatters(config)
    config[:fields].inject({}) do |hash, (field, opts)|
      if opts.is_a?(Hash) && opts.try(:header_formatters)
        hash << { field => (opts[:header_formatters] + defaults)  }
      else
        hash << { field => defaults }
      end
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

  def self.translations(fields)
    table = fields.inject({}) do |vocab, (field, opts)|
      if opts.is_a?(Hash) && opts.try(:translations)
        vocab << { field => opts[:translations] }
      else
        vocab << { field => [field] }
      end
    end
    table.try(:inverse) || {}
  end

  def self.translate(locale, value)
    locale[value] || value
  end

  def self.lexicon(fields)
    fields.inject({}) do |vocab, (field, opts)|
      if opts.try(:has_key?, :lexicon)
        vocab << { field => opts[:lexicon] }
      else
        vocab
      end
    end
  end

  def self.lex(locale, field, value)
    locale.try(field).try(value) || value
  end
end
