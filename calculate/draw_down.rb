module Calculate
  # DrawDown calculation for array of portfolios
  class DrawDown
    class << self
      # peak_val = Peak value before largest drop
      # lowest_val = Lowest value before new high established)
      # (peak_val - lowest_val) / peak_val
      # return percentage of max drop down value
      # TODO: Need confirmation about Quandl API's high value is before low value??
      def max_drawdown(peak_val, lowest_val)
        max_drawdown = (peak_val.to_f - lowest_val.to_f) / peak_val.to_f
        -(max_drawdown * 100).round(1)
      end

      # Given portfolios as array
      def max_drawdown_by_portfolios(portfolios)
        raise Common::Error::WrongInput, 'not array' unless portfolios.is_a? Array

        drawdowns = draw_down_hash(portfolios).compact
        return 0 if drawdowns.empty?

        max_value = drawdowns.max_by { |element| element[:loss] }
        max_value[:drawdown]
      end

      # All draw down selected with bottom and high peak
      def draw_down_hash(portfolios)
        raise Common::Error::WrongInput, 'not array' unless portfolios.is_a? Array

        top_index = 0
        top_date = ''
        bottom_index = 0
        result = []

        portfolios.each_with_index do |p_hash, index|
          p_hash.each do |date, item|
            if item > portfolios[top_index].values.first
              top_index = index
              top_date = date
              bottom_index = index
            elsif item < portfolios[bottom_index].values.first
              bottom_index = index

              result << {
                top_value: portfolios[top_index].values.first,
                top_index: top_index,
                top_date: top_date,
                low_value: item,
                low_index: index,
                low_date: date,
                loss: portfolios[top_index].values.first - item,
                drawdown: max_drawdown(portfolios[top_index].values.first, item)
              }
            end
          end
        end

        result
      end
    end
  end
end
