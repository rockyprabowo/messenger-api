# frozen_string_literal: true

module RequestSpecHelper
  # This is a really basic structure and data type checking based on Ruby Hash
  # keys and values checking.
  # Its functionality is very limited and only suitable for this interview mini project only.
  # Please use a proper RSpec matchers.
  RSpec::Matchers.define :be_json_representation_of do |expected|
    description do
      "be the JSON representation of #{expected}"
    end

    match do |actual|
      actual.keys == expected.keys &&
        actual.values.map(&:class) == expected.values.map(&:class)
    end

    failure_message do |actual|
      "expected #{actual} to be the JSON representation of #{expected}"
    end
  end
end
