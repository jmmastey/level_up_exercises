require 'yaml'

class Configuration
  def initialize(file_path)
    @raw = Configuration.normalize_partial(YAML.load_file(file_path))
  end

  def default_value(header)
    @raw.try(:fields).try(header).try(:default_value)
  end

  def formatters(defaults, key)
    @raw[:fields].inject({}) do |hash, (field, opts)|
      if opts.is_a?(Hash) && opts.try(key)
        hash << { field => (opts[key] + defaults) }
      else
        hash << { field => defaults }
      end
    end
  end

  def default_field_formatters
    @raw.try(:global).try(:fields).try(:formatters) || []
  end

  def field_keys
    @raw.try(:fields).try(:keys)
  end

  def field_formatters
    formatters(default_field_formatters, :formatters)
  end

  def default_header_formatters
    defaults = @raw.try(:global).try(:headers).try(:formatters) || []
    defaults << :to_sym
  end

  def header_formatters
    formatters(default_header_formatters, :header_formatters)
  end

  def field_translations
    @raw[:fields].inject({}) do |vocab, (field, opts)|
      if opts.try(:has_key?, :lexicon)
        vocab << { field => opts[:lexicon] }
      else
        vocab
      end
    end
  end

  def header_translations
    table = @raw[:fields].inject({}) do |vocab, (field, opts)|
      if opts.is_a?(Hash) && opts.try(:translations)
        vocab << { field => opts[:translations] }
      else
        vocab << { field => [field] }
      end
    end
    table.try(:inverse) || {}
  end

  def value_type(field)
    @raw.try(:fields).try(field).try(:type) || :symbol
  end

  def normalized_value(field, value)
    Configuration.normalize_value(value_type(field), value)
  end

  def self.normalize_partial(data)
    data.instance_exec(self) do |config|
      return config.normalize_partial_hash(self) if is_a?(Hash)
      return config.normalize_partial_array(self) if is_a?(Array)
      return config.normalize_value(:symbol, self) if is_a?(String)
      self
    end
  end

  def self.normalize_partial_hash(data)
    data.inject({}) { |a, (k, v)| a << { k.to_sym => normalize_partial(v) } }
  end

  def self.normalize_partial_array(data)
    data.inject([]) { |a, e| a << normalize_partial(e) }
  end

  def self.normalize_value(type, value)
    case type
    when :symbol then value.to_s.downcase.snake_case.to_sym
    when :integer then value.to_i
    else value
    end
  end
end
