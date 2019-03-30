#!/usr/bin/env ruby

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
    # Notification channels
    command_line = Interfaces::Cmd.new(arguments)
    slack_notification = Interfaces::SlackNotify.new

    stock_data = Client::Quandl.new.filter_by_date(
      command_line.stock_name,
      command_line.start_date,
      command_line.end_date
    )
    stock_objects = Models::Stock.load_from_dataset(stock_data)

    # To show all portfolio values
    command_line.all_stock_info(stock_objects)
    slack_notification.all_stock_info(stock_objects)

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
    command_line.first_three_drawdown(drawdown_hash)
    slack_notification.first_three_drawdown(drawdown_hash)

    # Show max drawdown
    max_drawdown = drawdown_hash.compact.max_by { |element| element[:loss] }
    command_line.max_drawdown(max_drawdown)
    slack_notification.max_drawdown(max_drawdown)

    # Show return value and rate
    rate = Calculate::Return.rate_by_portfolios(stock_objects)
    command_line.return_value(rate)
    slack_notification.return_value(max_drawdown)
  rescue StandardError => e
    puts e.message
  end
end

Task.show_info(ARGV)
