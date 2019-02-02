

## a)
## The process equation is x_t = 0.7 * x_{t - 1} - 0.3 * x_{t - 2} + u_t
## with u_t ~ WN(4)
## Its characteristic equation is lambda^2 - 0.7 * lambda + 0.3 = 0
## Find the roots of the equation

roots <- polyroot(c(0.3, -0.7, 1))

## Check if the roots are within the unit circle (i.e. less than 1 in absolute value)
abs(roots)

abs(roots) < 1

## b)
## Simulation

## Generate a white noise process with normal distribution
## with standard deviation equal to 2 (i.e. variance = 2 ^ 2 = 4)

n <- 1000
innovations <- rnorm(n, 2)

sim <- arima.sim(
  n = n, 
  model = list(
    ar=c(0.7, -0.3)
  ),
  innov = innovations
)

## c)

acf(sim)
pacf(sim)

## d)
fit <- arima(sim, order = c(1, 0, 0))
fit

## e)
## \hat{x_t} = ar1 * \hat{x_{t - 1}} + ar2 * \hat{x_{t - 2}}
## Lookup the results for ar1 and ar2 in the print output of fit (first line of the table)

## f)
tsdiag(fit)

## g) ## Ignore, not relevant for the exam

## i)

fit2 <- arima(sim, order = c(2, 0, 0))

tsdiag(fit2)
