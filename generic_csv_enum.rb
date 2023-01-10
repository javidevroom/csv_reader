# typed: true
# frozen_string_literal: true

class GenericCsvEnum < ::CSVEnum
  attr_reader :collection, :filename, :grape_entity

  alias to_path filename

  def initialize(collection, with:, filename: 'default.csv')
    @collection = collection
    @filename = filename
    @grape_entity = with
  end

  def each
    yield csv(headers) if show_headers?
    collection.each do |el|
      row = transform(el)
      next if row.nil?

      yield csv(row)
    end
  rescue StandardError => e
    ErrorHandling.report_error(e)
    raise e
  end

  private

  def headers
    grape_entity.const_get(:COLUMNS).values
  end

  def transform(element)
    keys = grape_entity.const_get(:COLUMNS).keys
    result = grape_entity.represent(element, only: keys).serializable_hash
    keys.map { |key| result[key] }
  end
end
