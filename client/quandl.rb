require 'faraday'
require 'json'
require 'dotenv'
require 'logger'
require 'byebug'

module Client
  class Quandl
    attr_accessor :connection

    DATA = 'data'.freeze
    METADATA = 'metadata'.freeze
    RETURN_FORMAT = 'json'.freeze

    # Parameters
    LIMIT = 'limit'.freeze
    COLUMN_INDEX = 'column_index'.freeze
    START_DATE = 'start_date'.freeze
    END_DATE = 'end_date'.freeze
    ORDER_BY = 'order'.freeze
    PERIOD = 'collapse'.freeze
    TRANSFORM = 'transform'.freeze
    DOWNLOAD_TYPE = 'download_type'.freeze

    # Filters
    ENTIRE = 'full'.freeze
    PARTIAL = 'partial'.freeze
    DAILY_PERIOD = 'daily'.freeze
    MONTHLY_PERIOD = 'monthly'.freeze
    DIFF_TRANSFORM = 'diff'.freeze
    RDIFF_TRANSFORM = 'rdiff'.freeze
    ASC = 'asc'.freeze
    DESC = 'desc'.freeze

    def initialize
      log = Logger.new(ENV['LOG_FILE_NAME'])
      log.level = Logger::DEBUG

      self.connection = Faraday.new(url: ENV['STOCK_HOST']) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger, log
        faraday.adapter  Faraday.default_adapter
      end
    end

    # Get Specific stock by name
    # name: stock name
    def stock_by_name(name, opts = {})
      stock_endpoint = "#{ENV['API_VERSION']}/datasets/#{ENV['DATABASE_CODE']}/#{name}/#{DATA}.#{RETURN_FORMAT}"
      get(stock_endpoint, opts)
    end

    # Metadata by name
    def metadata_by_name(name, opts = {})
      stock_endpoint = "#{ENV['API_VERSION']}/datasets/#{ENV['DATABASE_CODE']}/#{name}/#{METADATA}.#{RETURN_FORMAT}"
      get(stock_endpoint, opts)
    end

    # Get data set filter by dates
    def filter_by_date(name, start_date, end_date)
      stock_endpoint = "#{ENV['API_VERSION']}/datasets/#{ENV['DATABASE_CODE']}/#{name}.#{RETURN_FORMAT}"
      opts = {
        START_DATE => start_date,
        END_DATE => end_date,
        PERIOD => DAILY_PERIOD,
        ORDER_BY => ASC
      }
      get(stock_endpoint, opts)
    end

    # GET request with api key
    def get(end_point, options)
      response = connection.get(end_point, options.merge(api_key: ENV['API_KEY']))
      raise Common::Error::InvalidResponse, "Error code with :  #{response.status}" unless response.success?

      validate_as_json(response.body)
    end

    # Not fail with library error
    def validate_as_json(response)
      JSON.parse(response)
    rescue JSON::NestingError
      raise Common::Error::InvalidResponseContent, 'Too deep response'
    rescue JSON::ParserError
      raise Common::Error::InvalidResponseContent, 'Unexpected response'
    rescue JSON::MissingUnicodeSupport
      raise Common::Error::InvalidResponseContent, 'Invalid character in response'
    rescue JSON::UnparserError
      raise Common::Error::InvalidResponseContent, 'Unable to parse response'
    rescue JSON::JSONError
      raise Common::Error::InvalidResponseContent, 'Invalid response'
    end
  end
end
