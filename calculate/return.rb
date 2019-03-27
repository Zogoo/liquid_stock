module Calculate
  # Calculate over a single period of return, or rate of return,
  # https://en.wikipedia.org/wiki/Rate_of_return#Return
  class Return
    class << self
      def rate_by_portfolios(portfolios)
        final_value = portfolios.last.close
        initial_value = portfolios.first.close
        {
          rate: rate(final_value, initial_value),
          value: value(final_value, initial_value),
          initial_value: final_value,
          initial_date: portfolios.first.date,
          final_value: final_value,
          final_date: portfolios.last.date
        }
      end

      def rate(final_value, initial_value, addition = 0)
        final_value += addition
        ((final_value - initial_value) / initial_value * 100).round(1)
      end

      def value(final_value, initial_value)
        final_value - initial_value
      end
    end
  end
end
