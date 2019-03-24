module Calculate
  class Return
    class << self
      def rate_by_portfolios(portfolios)
        final_value = portfolios.last.close
        initial_value = portfolios.first.close
        rate(final_value, initial_value)
      end

      def rate(final_value, initial_value, addition = 0)
        final_value = final_value + addition
        ((final_value - initial_value) / initial_value * 100).round(1)
      end

      def value(final_value, initial_value)
        final_value - initial_value
      end
    end
  end
end
