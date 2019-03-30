require 'slack-notifier'

module Interfaces
  class SlackNotify < Base

    attr_accessor :notifier

    def initialize
      self.notifier = Slack::Notifier.new(
        ENV['SLACK_HOOK_URL'],
        channel: ENV['SLACK_CHANNEL'],
        username: ENV['SLACK_USERNAME']
      )
    end

    def all_stock_info(stock_objects)
      notifier.ping super(stock_objects)
    end

    def first_three_drawdown(data)
      notifier.ping super(data)
    end

    def max_drawdown(data)
      notifier.ping super(data)
    end

    def show_return_value(data)
      notifier.ping super(data)
    end
  end
end
