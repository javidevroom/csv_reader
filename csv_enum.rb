# typed: false
# frozen_string_literal: true

require 'csv'

# Superclass for generating CSVs.
#
# The subclass is expected to override these methods:
#
#   - headers - array of strings
#   - collection - data source, enumerable
#   - transform - convert an item in collection to a CSV row
#                 (returns array, matching the order in `headers`)
#   - to_path - filename of output csv
#
# Getting the CSV:
#
#   a) instance.each - enumerable, yielding rows as strings; suitable for streaming
#   b) instance.to_csv - string
#
class CSVEnum
  def initialize(*) = nil

  def to_path
    'default.csv'
  end

  def each
    yield csv(headers) if show_headers?
    collection.each do |el|
      row = transform(*Array(el))
      next if row.nil?

      yield csv(row)
    end
  end

  def to_csv
    to_enum.reduce(:+)
  end

  private

  def headers
    []
  end

  def show_headers?
    true
  end

  def collection
    []
  end

  def transform(_element)
    []
  end

  def csv(data)
    ::CSV.generate_line(data)
  end

  def flag(bool)
    bool ? 'Y' : 'N'
  end
end
