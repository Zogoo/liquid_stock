Stock information with max drawdown and return rate

1. Create .env and .env.test file

```
  STOCK_HOST='https://www.quandl.com'
  API_VERSION='api/v3'
  DATABASE_CODE='WIKI'
  API_KEY='YOUR API KEY'
  LOG_FILE_NAME='faraday.log'
```

2. Call with options

```
 ruby stock.rb AAPL Jan 1 2018 - Jan 5 2018

```
