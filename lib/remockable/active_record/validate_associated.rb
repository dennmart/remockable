RSpec::Matchers.define(:validate_associated) do |*attribute|
  extend Remockable::ActiveModel::Helpers

  @type = :associated
  @expected = attribute.extract_options!
  @attribute = attribute.shift

  valid_options %w(if message on unless)

  match do |actual|
    validator = validator_for(@attribute)
    validator && options_match(validator) && conditionals_match(validator)
  end

  failure_message_for_should do |actual|
    "Expected #{subject.class.name} to #{description}"
  end

  failure_message_for_should_not do |actual|
    "Did not expect #{subject.class.name} to #{description}"
  end

  description do
    with = " with #{expected.inspect}" if expected.any?
    "validate #{type} #{@attribute}#{with}"
  end
end
