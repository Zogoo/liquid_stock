module Interfaces
  # Command line interface handler
  class Cmd < Base
    def show_stock_data(stock_objects)
      stock_objects.each do |obj|
        puts "#{obj.date}: Closed at #{obj.close} (#{obj.low} ~ #{obj.high})"
      end
      puts ''
    end

    def show_first_three_drawdown(data)
      puts 'First 3 Drawdowns:'
      3.times do |count|
        print "#{data[count][:drawdown]}% "
        print "(#{data[count][:top_value]} on #{data[count][:top_date]} -> "
        print "#{data[count][:low_value]} on #{data[count][:low_date]}) \r\n"
      end
      puts ''
    end

    def show_max_drawdown(data)
      print "Maximum drawdown: #{data[:drawdown]}% "
      print "(#{data[:top_value]} on #{data[:top_date]} -> "
      print "#{data[:low_value]} on #{data[:low_date]}) \r\n"
      puts ''
    end

    def show_return_value(data)
      print "Return: #{data[:value]}"
      print "[+#{data[:rate]}]"
      print "(#{data[:initial_value]} on #{data[:initial_date]} -> "
      print "#{data[:final_value]} on #{data[:final_date]}) \r\n"
      puts ''
    end

    private

    def validate
      raise 'Wrong input for stock name' unless Validation::Input.valid_stock_name?(stock_name)
      raise 'Wrong input for start date' unless Validation::Input.valid_date?(start_date)
      raise 'Wrong input for end date' unless Validation::Input.valid_date?(end_date)
    end
  end
end
