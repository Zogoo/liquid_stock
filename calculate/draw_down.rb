module Calculate
  class DrawDown
    class << self
      # peak_val = Peak value before largest drop
      # lowest_val = Lowest value before new high established)
      # (peak_val - lowest_val) / peak_val
      # return percentage of max drop down value
      # TODO: Need confirmation about Quandl API's high value is the peak value or not?
      def max_drawdown(peak_val, lowest_val)
        max_drowdown = (peak_val.to_f - lowest_val.to_f) / peak_val.to_f
        -(max_drowdown * 100).round(1)
      end

      # Given portfolios as array
      def max_drawdown_by_portfolios(portfolios)
        raise Common::Error::WrongInput, 'not array' unless portfolios.is_a? Array

        peak_value_hash = draw_down_hash(portfolios).compact.max_by { |element| element[:loss] }
        max_drawdown(peak_value_hash[:top_value], peak_value_hash[:lowest_value])
      end

      # All draw down selected with bottom and high peak
      def draw_down_hash(portfolios)
        raise Common::Error::WrongInput, 'not array' unless portfolios.is_a? Array

        top_index = 0
        bottom_index = 0

        portfolios.map.with_index do |item, index|
          if item >= portfolios[top_index]
            top_index = index
            bottom_index = index
            nil
          else
            if item < portfolios[bottom_index]
              bottom_index = index
              {
                top_value: portfolios[top_index],
                top_index: top_index,
                lowest_value: item,
                low_index: index,
                loss: portfolios[top_index] - item
              }
            end
          end
        end
      end
    end
  end
end
