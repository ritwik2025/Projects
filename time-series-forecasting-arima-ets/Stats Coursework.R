#Part 1 Manual Modelling
#Setting the working directory
setwd("C:/Users/Ritwik Singh/OneDrive - University of Bath/Documents/Semester 1/Business Statistics and Forecasting/Coursework")

#Reading of the CSV data
part1_data <- read.csv("MN50751CourseworkData2023.csv")

#Installing necessary libraries necessary for the coursework
library(Mcomp)
library(ggplot2)
library(lubridate)
library(lmtest)

#Loading the data set: Loads a specific time series data set (M3[[1909]]) into the variable part1_data and displays its contents.
part1_data <- M3[[1909]]
part1_data

#Summary and extraction of historical and future values
cw_historical_values <- part1_data$x
cw_historical_values

cw_future_values <- part1_data$xx
cw_future_values

#Summary statistics: Provides summary statistics for historical and future values.
summary(cw_historical_values)
summary(cw_future_values)

#Plotting time series data: Plots the historical values with the specified title and axis labels.
plot(cw_historical_values, main = "Production of Glass Containers Over Time", ylab = "Production", xlab = "Year")

#Decomposition of time series data into its components (trend, seasonality, and remainder) and plots the components.
cw_decomposed_data <- decompose(cw_historical_values)
plot(cw_decomposed_data)

#Augmented Dicky-Fuller(ADF) Test for the historical values.
adf <- adf.test(cw_historical_values)
adf

#Autocorrelation and Partial Autocorrelation Functions for the historical values.
acf(cw_historical_values, main = "Autocorrelation Function of Glass Containers Production")

pacf(cw_historical_values, main = "Partial Autocorrelation Function of Glass Containers Production")

#Shapiro-Wilk test on the historical values to assess normality.
shapiro.test(cw_historical_values)

#Simple linear regression: Creates a simple linear regression model using a time trend and seasonality.
time <- 1:length(cw_historical_values)
regression_model <- tslm(cw_historical_values ~ trend + season)
summary(regression_model)

#Residual analysis: Plotting residuals against fitted values to assess the model's performance
residuals <- residuals(regression_model)
plot(fitted(regression_model), residuals, xlab="Fitted Values", ylab="Residuals", 
     main="Residuals vs Fitted Values")
#Normality tests on residuals: Performing independence, normality, and equal variance tests
#Durbin-Watson Test for independence
dwtest(regression_model) 
#QQ plot for assessing normality
qqnorm(residuals)
qqline(residuals, col='red')
#Shapiro-Wilk Test for normality
shapiro.test(residuals)
#Breusch-Pagan Test for equal variance
bptest(regression_model)

#Forecasting with regression model: Generates a forecast (forecast_values) for the next 18 periods using the regression model.
forecast_values <- forecast(regression_model, h=18)
forecast_values
plot(forecast_values, main = "Forecast for 18 periods using Regression Model", xlab= "Year", ylab= "Production")

#Exponential Smoothing (ETS) model and forecast: Fits an ETS model to the historical values, displays its summary, and generates a forecast (ets_forecast) for the next 18 periods.
fit1 <- ets(cw_historical_values, model="ANN")
summary(fit1)
fit2 <- ets(cw_historical_values, model="AAN", damped=FALSE)
summary(fit2)
fit3 <- ets(cw_historical_values, model="AAN", damped=TRUE)
summary(fit3)
fit4 <- ets(cw_historical_values, model="AAA", damped=TRUE)
summary(fit4)
fit5 <- ets(cw_historical_values, model="MAM", damped=TRUE)
summary(fit5)
best_ets_model <- forecast(fit5, h=18)
forecast(fit5)
plot(fit5)

#ARIMA Model and forecast: 
p <- c(3,3,4,4,2,0)
d <- c(0,0,0,0,0,1)
q <- c(0,0,0,0,0,1)
P <- c(2,1,2,1,2,0)
D <- c(1,1,1,1,1,1)
Q <- c(0,0,0,0,0,1)

n_models <- 6
AICc <- array(NA, n_models)

for (m in 1:n_models){
  fit <- Arima(cw_historical_values, order=c(p[m],d[m],q[m]), seasonal=c(P[m],D[m],Q[m]))
  AICc[m] <- fit$aicc
}
AICc

bm <- which.min(AICc)
fit <- Arima(cw_historical_values, order=c(p[bm],d[bm],q[bm]), seasonal=c(P[bm],D[bm],Q[bm]))
summary(fit)
tsdisplay(residuals(fit), xlab="Year")
arima_forecast <- forecast(fit)
plot(arima_forecast, main = "Forecast of the Best ARIMA Model", xlab="Year", ylab="Production")
ljung_box_test <- Box.test(residuals(arima_forecast), lag = 8, type = "Ljung-Box")
ljung_box_test
tsdisplay(residuals(arima_forecast))

########################################################################################

#Part 2 Batch Forecasting
library(forecast)
tsset <- seq(1508, 2498, 10)
y <- M3[tsset]
horizon <- 18
mape_matrix <- matrix(0, nrow = length(tsset), ncol = 5)
mae_matrix <- matrix(0, nrow = length(tsset), ncol = 5)
rmse_matrix <- matrix(0, nrow = length(tsset), ncol = 5)

#ETS Forecast Strategy
for (tsi in seq_along(tsset)) {
  series <- y[[tsi]]$x
  
  
  yt <- head(series, length(series))
  actual_values <- y[[tsi]]$xx
  
  
  ets_model <- ets(yt)
  
  forecast_values <- forecast(ets_model, h = horizon)$mean
  
  mape <- 100 * mean(abs(actual_values - forecast_values) / abs(actual_values), na.rm = TRUE)
  mae <- mean(abs(actual_values - forecast_values), na.rm = TRUE)
  rmse <- sqrt(mean((actual_values - forecast_values)^2, na.rm = TRUE))
  
  mape_matrix[tsi, ] <- mape
  mae_matrix[tsi, ] <- mae
  rmse_matrix[tsi, ] <- rmse
  
  cat(sprintf("Forecast for series %d:\n", tsset[tsi]))
  print(forecast_values)
  cat(sprintf("MAPE: %.2f%%\n", mape))
  cat(sprintf("MAE: %.2f\n", mae))
  cat(sprintf("RMSE: %.2f\n", rmse))
}

#ARIMA Forecast Strategy
for (tsi in seq_along(tsset)) {
  series <- y[[tsi]]$x
  
  yt <- head(series, length(series))
  actual_values <- y[[tsi]]$xx
  
  
  arima_model <- auto.arima(yt)
  
  forecast_values <- forecast(arima_model, h = horizon)$mean
  
  mape <- 100 * mean(abs(actual_values - forecast_values) / abs(actual_values), na.rm = TRUE)
  mae <- mean(abs(actual_values - forecast_values), na.rm = TRUE)
  rmse <- sqrt(mean((actual_values - forecast_values)^2, na.rm = TRUE))
  
  mape_matrix[tsi, ] <- mape
  mae_matrix[tsi, ] <- mae
  rmse_matrix[tsi, ] <- rmse
  
  cat(sprintf("Forecast for series %d:\n", tsset[tsi]))
  print(forecast_values)
  cat(sprintf("MAPE: %.2f%%\n", mape))
  cat(sprintf("MAE: %.2f\n", mae))
  cat(sprintf("RMSE: %.2f\n", rmse))
}

#ETS or ARIMA Forecast Strategy
for (tsi in seq_along(tsset)) {
  
  
  #Load series and split into training and validation data
  series <- y[[tsi]]$x
  past_data <- head(series, length(series) - horizon)
  future_data <- tail(series, horizon)
  
  future_data <- y[[tsi]]$xx
  
  FCs <- array(0, c(2, horizon))
  MAPEs <- numeric(2)
  
  
  for (m in 1:2){
    if (m==1){
      fit <- ets(past_data)
    } else {
      fit <- auto.arima(past_data)
    }
    FCs[m,] <- forecast(fit, h = horizon)$mean
    
    MAPEs <- array(0, 2)
    for (m in 1:2){
      MAPEs[m] <- 100 * mean(abs(future_data - FCs[m,])/abs(future_data))
    }
  }
  
  
  best_model <- which.min(MAPEs)
  freq_best[best_model] <- freq_best[best_model] + 1
  
  cat(sprintf("For series %d, selected model: %s\n", tsset[tsi], ifelse(best_model == 1, "ETS", "ARIMA")))
  
  if (best_model == 1) {
    fit_out <- ets(series)
  } else {
    fit_out <- auto.arima(series)
  }
  forecast_out <- forecast(fit_out, h = horizon)$mean
  
  actual_values <- y[[tsi]]$xx
  
  forecast_values <- forecast_out

  mape_matrix[tsi, ] <- 100 * mean(abs(actual_values - forecast_values) / abs(actual_values), na.rm = TRUE)
  mae_matrix[tsi, ] <- mean(abs(actual_values - forecast_values), na.rm = TRUE)
  rmse_matrix[tsi, ] <- sqrt(mean((actual_values - forecast_values)^2, na.rm = TRUE)) 
}

#Benchmark and Strategies
##Naive Forecast Strategy
for (tsi in seq_along(tsset)) {
  series <- y[[tsi]]$x
  
  past_data <- head(series, length(series))
  actual_values <- y[[tsi]]$xx
  
  last_value <- tail(past_data, 1)
  forecast_values <- rep(last_value, horizon)
  
  mape <- 100 * mean(abs(actual_values - forecast_values) / abs(actual_values), na.rm = TRUE)
  mae <- mean(abs(actual_values - forecast_values), na.rm = TRUE)
  rmse <- sqrt(mean((actual_values - forecast_values)^2, na.rm = TRUE))
  
  mape_matrix[tsi, ] <- mape
  mae_matrix[tsi, ] <- mae
  rmse_matrix[tsi, ] <- rmse
  
  cat(sprintf("Forecast for series %d:\n", tsset[tsi]))
  print(forecast_values)
  cat(sprintf("MAPE: %.2f%%\n", mape))
  cat(sprintf("MAE: %.2f\n", mae))
  cat(sprintf("RMSE: %.2f\n", rmse))
}

##Seasonal Naive Forecast
for (tsi in seq_along(tsset)) {
  series <- y[[tsi]]$x
  
  past_data <- head(series, length(series))
  actual_values <- y[[tsi]]$xx
  
  forecast_values <- forecast(snaive(past_data, h=18))$mean
  
  mape <- 100 * mean(abs(actual_values - forecast_values) / abs(actual_values), na.rm = TRUE)
  mae <- mean(abs(actual_values - forecast_values), na.rm = TRUE)
  rmse <- sqrt(mean((actual_values - forecast_values)^2, na.rm = TRUE))
  
  mape_matrix[tsi, ] <- mape
  mae_matrix[tsi, ] <- mae
  rmse_matrix[tsi, ] <- rmse
  
  cat(sprintf("Forecast for series %d:\n", tsset[tsi]))
  print(forecast_values)
  cat(sprintf("MAPE: %.2f%%\n", mape))
  cat(sprintf("MAE: %.2f\n", mae))
  cat(sprintf("RMSE: %.2f\n", rmse))
}  

##Mean Forecast Strategy
for (tsi in seq_along(tsset)) {
  series <- y[[tsi]]$x
  
  past_data <- head(series, length(series))
  actual_values <- y[[tsi]]$xx
  
  forecast_values <- rep(mean(past_data), horizon)
  
  mape <- 100 * mean(abs(actual_values - forecast_values) / abs(actual_values), na.rm = TRUE)
  mae <- mean(abs(actual_values - forecast_values), na.rm = TRUE)
  rmse <- sqrt(mean((actual_values - forecast_values)^2, na.rm = TRUE))
  
  mape_matrix[tsi, ] <- mape
  mae_matrix[tsi, ] <- mae
  rmse_matrix[tsi, ] <- rmse
  
  cat(sprintf("Forecast for series %d:\n", tsset[tsi]))
  print(forecast_values)
  cat(sprintf("MAPE: %.2f%%\n", mape))
  cat(sprintf("MAE: %.2f\n", mae))
  cat(sprintf("RMSE: %.2f\n", rmse))
}

print("Mean MAPE:")
print(mean(mape_matrix, na.rm = TRUE))
print("Mean MAE:")
print(mean(mae_matrix, na.rm = TRUE))
print("Mean RMSE:")
print(mean(rmse_matrix, na.rm = TRUE))