# typed: true
# frozen_string_literal: true

module HolidayPay
  class HistoricRequestsCSV < ::GenericCsvEnum
    def initialize(collection, with:, working_week_ending_on:)
      super(collection, with: with, filename: "holiday_pay_historic_requests_#{working_week_ending_on}.csv")
    end
  end
end
