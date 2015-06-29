class NameFormatError < RuntimeError
  def message
    'The robot name was not in the correct format.'
  end
end

class NameTakenError < RuntimeError
  def message
    'That robot name has already been registered.'
  end
end
