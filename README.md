# Stock information

This script will give you stock information, max drawdown and rate of return by your entered date range.


# How to use

###### 1. Create .env and .env.test file with following env variables

```
  STOCK_HOST='https://www.quandl.com'
  API_VERSION='api/v3'
  DATABASE_CODE='WIKI'
  API_KEY='YOUR API KEY'
  LOG_FILE_NAME='faraday.log'
  SLACK_HOOK_URL=''
  SLACK_CHANNEL='test'
  SLACK_USERNAME='LiquidStock'
```

To get the SLACK_HOOK_URL you need:

  * Go to https://slack.com/apps/A0F7XDUAZ-incoming-webhooks
  * Choose your team, press "Configure"
  * In configurations press "Add configuration"
  * Choose channel, press "Add Incoming WebHooks integration"

To get the API KEY you need:

  * Quandl API KEY. You need to register your account from here https://www.quandl.com/sign-up-modal
  * They will send you API KEY to your email address

###### 2. Call with following options

```
 API_KEY=<your key> ./stock.rb STOCK_NAME START_DATE - END_DATE

```

 API_KEY: You can put in to env file or provide it on the command line.

 STOCK_NAME: Official stock name. For example: Nike -> NKE, MacDonalds -> MCE, Apple Inc -> AAPL

 START_DATE and END_DATE: Stock filter date format with MMM DD YEAR. For example: Jan 1 2018

 Note: Between start date and end date, please provide hyphen.

###### 3. Samples:

#### Apple

```
./stock.rb AAPL Jan 1 2018 - Jan 5 2018
2018-01-02: Closed at 172.26 (169.26 ~ 172.3)
2018-01-03: Closed at 172.23 (171.96 ~ 174.55)
2018-01-04: Closed at 173.03 (172.08 ~ 173.47)
2018-01-05: Closed at 175.0 (173.05 ~ 175.37)

First 3 Drawdowns:
-1.8% (172.3 on 2018-01-02 -> 169.26 on 2018-01-02)
-1.5% (174.55 on 2018-01-03 -> 171.96 on 2018-01-03)
-1.3% (175.37 on 2018-01-05 -> 173.05 on 2018-01-05)

Maximum drawdown: -1.8% (172.3 on 2018-01-02 -> 169.26 on 2018-01-02)
```

#### MacDonalds

```
./stock.rb MCD Jan 1 2018 - Jan 5 2018
2018-01-02: Closed at 173.22 (172.66 ~ 174.4799)
2018-01-03: Closed at 172.49 (172.0 ~ 173.64)
2018-01-04: Closed at 173.7 (172.73 ~ 174.13)
2018-01-05: Closed at 174.05 (173.4 ~ 175.0)

First 3 Drawdowns:
-1.0% (174.4799 on 2018-01-02 -> 172.66 on 2018-01-02)
-1.4% (174.4799 on 2018-01-02 -> 172.0 on 2018-01-03)
-0.9% (175.0 on 2018-01-05 -> 173.4 on 2018-01-05)

Maximum drawdown: -1.4% (174.4799 on 2018-01-02 -> 172.0 on 2018-01-03)
```

#### NIKE

```
./stock.rb NKE Jan 1 2018 - Jan 5 2018
2018-01-02: Closed at 63.49 (62.85 ~ 63.49)
2018-01-03: Closed at 63.48 (62.76 ~ 63.66)
2018-01-04: Closed at 63.44 (62.55 ~ 63.55)
2018-01-05: Closed at 63.98 (63.4701 ~ 64.3)

First 3 Drawdowns:
-1.0% (63.49 on 2018-01-02 -> 62.85 on 2018-01-02)
-1.4% (63.66 on 2018-01-03 -> 62.76 on 2018-01-03)
-1.7% (63.66 on 2018-01-03 -> 62.55 on 2018-01-04)

Maximum drawdown: -1.7% (63.66 on 2018-01-03 -> 62.55 on 2018-01-04)
```

Slack notification

![alt tag](https://docs.google.com/uc?id=1QWic9lKrLD62DXuN62kRFBuBEqH7kjyj)

# TODO

1. Spec test for edge cases
2. Performance test and update logics for performance
