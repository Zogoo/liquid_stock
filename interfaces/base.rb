module Interfaces
  # Base class for output interface
  class Base
    attr_accessor :stock_name, :start_date, :end_date

    def initialize(opts)
      self.stock_name = opts.first
      date_seperator_index = opts.index('-')
      self.start_date = opts.slice(1, date_seperator_index - 1).join(' ')
      self.end_date = opts.slice(date_seperator_index + 1, opts.size - 1).join(' ')
      validate
    end

    def all_stock_info(stock_objects)
      stock_objects.map do |obj|
        "#{obj.date}: Closed at #{obj.close} (#{obj.low} ~ #{obj.high})\r\n"
      end.join
    end

    def first_three_drawdown(data)
      output = []
      output << "First 3 Drawdowns: \r\n"
      3.times do |count|
        output << "#{data[count][:drawdown]}% "
        output << "(#{data[count][:top_value]} on #{data[count][:top_date]} -> "
        output << "#{data[count][:low_value]} on #{data[count][:low_date]}) \r\n"
      end
      output.join
    end

    def max_drawdown(data)
      output = []
      output << "Maximum drawdown: #{data[:drawdown]}% "
      output << "(#{data[:top_value]} on #{data[:top_date]} -> "
      output << "#{data[:low_value]} on #{data[:low_date]}) \r\n"
      output.join
    end

    def return_value(data)
      output = []
      output << "Return: #{data[:value]}"
      output << "[+#{data[:rate]}]"
      output << "(#{data[:initial_value]} on #{data[:initial_date]} -> "
      output << "#{data[:final_value]} on #{data[:final_date]}) \r\n"
      output.join
    end

    protected

    def validate
      raise 'Wrong input for stock name' unless Validation::Input.valid_stock_name?(stock_name)
      raise 'Wrong input for start date' unless Validation::Input.valid_date?(start_date)
      raise 'Wrong input for end date' unless Validation::Input.valid_date?(end_date)
    end
  end
end
