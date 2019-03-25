module Interfaces
  class Cmd
    attr_accessor :stock_name, :start_date, :end_date

    def initialize(opts)
      self.stock_name = opts.first
      date_seperator_index = opts.index('-')
      self.start_date = opts.slice(1, date_seperator_index - 1).join(' ')
      self.end_date = opts.slice(date_seperator_index + 1, opts.size - 1).join(' ')
      validate
    end

    def show_stock_data(data)
      data.each do |obj|
        puts "#{obj.date}: Closed at #{obj.close} (#{obj.low} ~ #{obj.high})"
      end
      puts ''
    end

    def show_fist_three_drawdown(data, stock_objects)
      puts 'First 3 Drawdowns:'
      3.times do |count|
        print "#{data[count][:drawdown]}% "
        print "(#{data[count][:top_value]} on #{stock_objects[data[count][:top_index]].date} -> "
        print "#{data[count][:low_value]} on #{stock_objects[data[count][:low_index]].date}) \r\n"
      end
      puts ''
    end

    def show_max_drawdown(data)
      print "Maximum drawdown: #{data[:drawdown]}% "
      print "(#{data[:top_value]} on #{stock_objects[data[count][:top_index]].date} -> "
      print "#{data[:low_value]} on #{stock_objects[data[count][:low_index]].date}) \r\n"
      puts ''
    end

    def show_return_value(data)
      print "Return: #{data.return_value}"
      print "[+#{data.return_rate}]"
      print "(#{data.first.close} on #{data.first.date} -> "
      print "#{data.last.close} on #{data.last.date}) \r\n"
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
