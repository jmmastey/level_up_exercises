# This custom matcher can be used to test
# validates_format_of an object attribute

RSpec::Matchers.define :allow_value do |value, attribute|
  match do |object|
    object.send("#{attribute}=", value)
    object.valid?
  end

  failure_message do |model|
    "expected to allow value = #{value} to be set on #{attribute}"
  end

  failure_message_when_negated do |model|
    "expected to not allow value = #{value} to be set on #{attribute}"
  end

  description do |model|
    "sets a valid value of #{value} to the attribute = #{attribute} on the #{model.class}"
  end
end
