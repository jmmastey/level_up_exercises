class NameValidator
  PATTERN = /[[:alpha:]]{2}[[:digit:]]{3}/

  def validate_name(name, registry)
    raise NameFormatError unless name =~ PATTERN
    raise NameTakenError if registry.names.include?(name)
  end
end
