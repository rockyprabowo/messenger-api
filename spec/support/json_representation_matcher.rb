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
      traverse_structure(actual, expected)
    end

    failure_message do |actual|
      "expected #{actual} to be the JSON representation of #{expected}"
    end
  end

  def traverse_structure(actual, expected)
    expected.each do |key, type_or_value|
      is_a_hash_item = valid_hash_key(actual, key)
      case type_or_value
      when Hash
        return false unless is_a_hash_item && traverse_structure(actual[key], type_or_value)
      when Array
        next if type_or_value.eql?([]) && actual[key].eql?([])

        return false unless actual[key].is_a?(Array) &&
                            actual[key].each do |item|
                              break false unless traverse_structure(item, type_or_value.first)
                            end
      else
        begin
          return false unless is_a_hash_item && actual[key].is_a?(type_or_value)
        rescue StandardError => _e
          return false unless is_a_hash_item && actual[key].eql?(type_or_value)
        end
      end
    end
  end

  def valid_hash_key(hash, key)
    hash.is_a?(Hash) && hash.key?(key)
  end
end
