library(xts)
# a) Read data
gdp <- read.csv('https://s3.eu-central-1.amazonaws.com/sf-timeseries/data/gdp_bg_qrt_2000-2017.csv')

# b) Create time series object
timeIndex <- as.yearqtr(gdp$Index, format = '%YQ%q')
gdpSeries <- xts(gdp$GDP, order.by = timeIndex)

gdpSeries

plot(gdpSeries)

lagGdpSeries <- lag(gdpSeries)
growthRates <- log(gdpSeries) - log(lagGdpSeries)

plot(growthRates)

lagGdpSeries4 <- lag(gdpSeries, 4)
growthRates4 <- log(gdpSeries) - log(lagGdpSeries4)

plot(growthRates4)

acf(growthRates4, na.action = na.omit)
pacf(growthRates4, na.action = na.omit)


fitAR1 <- arima(growthRates4, order = c(1, 0, 0))
fitAR1

tsdiag(fitAR1)

fitAR2 <- arima(growthRates4, order = c(2, 0, 0))
fitAR2

tsdiag(fitAR2)

predict(fitAR1, 1)

