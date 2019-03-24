require 'dotenv/load'

Dir['./client/*.rb'].each { |file| require file }
Dir['./common/*.rb'].each { |file| require file }
Dir['./interfaces/*.rb'].each { |file| require file }
Dir['./calculate/*.rb'].each { |file| require file }
Dir['./models/*.rb'].each { |file| require file }
Dir['./validations/*.rb'].each { |file| require file }

class Task
  def self.show_info(arguments)
    interface = Interfaces::Cmd.new(arguments)
    stock_data = Client::Quandl.new.filter_by_date(
      interface.stock_name,
      interface.start_date,
      interface.end_date
    )
    stock_objects = Models::Stock.load_from_dataset(stock_data)
    interface.show_stock_data(stock_objects)
    byebug
    max_drow_down = Calculate::DrawDown.draw_down_hash(stock_objects)
    interface.show_fist_three_drowdown(max_drow_down)
    max_drow_down = Calculate::DrawDown.max_drawdown(stock_objects)
    interface.show_max_drowdown(max_drow_down)
    return_rate = Calculate::Rate.rate(stock_objects)
    return_value = Calculate::Rate.value(stock_objects)
    interface.show_return_value(rate_value, return_rate)
  rescue => e
    puts e.message
  end
end

Task.show_info(ARGV)
