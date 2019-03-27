module Interfaces
  class Slack < Base
    attr_accessor :content

    def initialize
      content = []
    end

    def all_stock_info(stock_objects)
      content << super(stock_objects)
      content << "\r\n"
    end

    def first_three_drawdown(data)
      content << super(data)
      content << "\r\n"
    end

    def max_drawdown(data)
      content << super(data)
      content << "\r\n"
    end

    def show_return_value(data)
      content << super(data)
    end
  end
end
