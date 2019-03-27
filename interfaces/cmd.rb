module Interfaces
  # Command line interface handler
  class Cmd < Base
    def all_stock_info(stock_objects)
      puts super(stock_objects)
      puts ''
    end

    def first_three_drawdown(data)
      puts super(data)
      puts ''
    end

    def max_drawdown(data)
      puts super(data)
      puts ''
    end

    def show_return_value(data)
      puts super(data)
    end
  end
end
