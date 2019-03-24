require 'date'

module Validation
  class Input
    class << self
      def valid_date?(date)
        Date.parse(date)
        true
      rescue ArgumentError
        false
      end

      def valid_stock_name?(code)
        code.match?(/[A-Z]+/)
      end
    end
  end
end
