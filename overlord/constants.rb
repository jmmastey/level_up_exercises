DEBUG = true
ERROR_TYPES = [StandardError]
ERRORS = {
  already_inactive: 'The bomb is already active.',
  already_inactive: 'The bomb is already inactive.',
  exploded: 'The bomb has been exploded and cannot be armed/disarmed.',
  incorrect_code: ->(field) { 'The ' + FIELDS[field.to_sym] + ' you entered is incorrect.' },
  numeric: ->(field) { FIELDS[field.to_sym] + ' must be numeric' },
  required: ->(field) { 'The ' + FIELDS[field.to_sym] + ' was not provided.' },
}
FIELDS = {
  activation_code: 'Activation Code',
  deactivation_code: 'Deactivation Code',
}
