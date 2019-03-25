# frozen_string_literal: true

# !/usr/bin/env ruby

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

    # To show all portfolio values
    interface.show_stock_data(stock_objects)

    # To show all first 3 drawdown
    # TODO: To avoid generate new array of portfolios
    portfolios = stock_objects.map { |obj| [obj.open, obj.high, obj.low, obj.close] }.reverse.flatten
    byebug
    drawdown_hash = Calculate::DrawDown.draw_down_hash(portfolios).compact
    interface.show_fist_three_drawdown(drawdown_hash, stock_objects)
    max_drawdown = drawdown_hash.compact.max_by { |element| element[:loss] }
    interface.show_max_drawdown(max_drawdown, stock_objects)
    byebug

    return_rate = Calculate::Rate.rate(stock_objects)
    return_value = Calculate::Rate.value(stock_objects)
    interface.show_return_value(rate_value, return_rate)
  rescue StandardError => e
    puts e.message
  end
end

Task.show_info(ARGV)
