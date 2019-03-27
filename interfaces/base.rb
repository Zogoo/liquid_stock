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
  end
end
