# frozen_string_literal: true

# !/usr/bin/env ruby

require 'dotenv/load'

Dir['./client/*.rb'].each { |file| require file }
Dir['./common/*.rb'].each { |file| require file }
Dir['./interfaces/*.rb'].each { |file| require file }
Dir['./calculate/*.rb'].each { |file| require file }
Dir['./models/*.rb'].each { |file| require file }
Dir['./validations/*.rb'].each { |file| require file }

# Command line task for show stock info
# as same as requirement
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
    # Convert portfolios for interfaces
    portfolios = []
    stock_objects.each do |item|
      portfolios << { item.date => item.open }
      portfolios << { item.date => item.high }
      portfolios << { item.date => item.low }
      portfolios << { item.date => item.close }
    end
    drawdown_hash = Calculate::DrawDown.draw_down_hash(portfolios).compact

    # Show first 3 data
    interface.show_first_three_drawdown(drawdown_hash)
    max_drawdown = drawdown_hash.compact.max_by { |element| element[:loss] }

    # Show max drawdown
    interface.show_max_drawdown(max_drawdown)

    # Show return value and rate
    rate = Calculate::Return.rate_by_portfolios(stock_objects)
    interface.show_return_value(rate)
  rescue StandardError => e
    puts e.message
  end
end

Task.show_info(ARGV)
