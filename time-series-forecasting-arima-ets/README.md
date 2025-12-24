# 📈 Glass Container Production Forecasting  
> Time Series Analysis & Predictive Modelling

## 📌 Executive Summary

This project analyses historical **glass container production data** to identify trends, seasonality, and optimal forecasting models.  
Using **time series decomposition, regression, Exponential Smoothing (ETS), and ARIMA**, the study builds statistically validated models to generate **18-month production forecasts** for business planning.

The final **hybrid ETS-or-ARIMA strategy** delivers the most accurate forecasts, outperforming standard benchmarks such as **Naive, Seasonal Naive, and Mean models**.

---

## 🔎 Problem Statement

Manufacturing companies require accurate production forecasts to support:

- Inventory planning  
- Capacity management  
- Supply chain optimisation  

However, production data contains **trend, seasonality, and autocorrelation**, making simple forecasting unreliable.  
This project addresses how statistical time-series models can be used to produce **reliable and interpretable forecasts**.

---

## 🎯 Objectives

- Identify trends and seasonality in production data  
- Test normality, independence, and model assumptions  
- Build and compare **Regression, ETS, and ARIMA models**  
- Select the best-performing forecasting strategy  
- Produce accurate **18-month production forecasts**

---

## 📂 Dataset

- Monthly glass container production data  
- Period: **1981 – 1991**  
- Strong seasonal and trend components  

---

## ⚙️ Methodology

The analysis followed a structured forecasting pipeline:

1. Exploratory time-series visualisation  
2. Decomposition into **trend, seasonality, and random components**  
3. Statistical testing (Shapiro-Wilk, Durbin-Watson, Breusch-Pagan)  
4. Linear regression with seasonal dummies  
5. ETS model selection  
6. ARIMA model selection using **AICc**  
7. Forecast evaluation using **MAPE, MAE, RMSE**

---

## 📊 Key Analyses & Outcomes

### 1️⃣ Production Time Series

The raw time series shows **clear seasonality and long-term variation**, confirming the need for seasonal forecasting models.

<img src="https://github.com/ritwik2025/Projects/blob/main/Semester%201/Business%20Statistics%20and%20Forecasting/Coursework/outcomes/production_time_series.png?raw=true" width="700"/>

---

### 2️⃣ Seasonal Decomposition

Additive decomposition separates the data into:

- **Trend** – long-term movement  
- **Seasonal** – recurring yearly patterns  
- **Random** – short-term noise  

<img src="https://github.com/ritwik2025/Projects/blob/main/Semester%201/Business%20Statistics%20and%20Forecasting/Coursework/outcomes/seasonal_decomposition.png?raw=true" width="700"/>

This confirms strong seasonality and structural variation in production.

---

### 3️⃣ ARIMA Forecast

After testing multiple configurations using **AICc**, the best model selected was:

**ARIMA (0,1,1)(0,1,1)[12]**

This model captures both **seasonal and short-term dependencies**.

<img src="https://github.com/ritwik2025/Projects/blob/main/Semester%201/Business%20Statistics%20and%20Forecasting/Coursework/outcomes/arima_forecast.png?raw=true" width="700"/>

---

### 4️⃣ ETS vs ARIMA Forecast Comparison

The **hybrid strategy** dynamically selects the better model between ETS and ARIMA based on validation error.

<img src="https://github.com/ritwik2025/Projects/blob/main/Semester%201/Business%20Statistics%20and%20Forecasting/Coursework/outcomes/ets_arima_comparison.png?raw=true" width="700"/>

This approach produced the **lowest forecasting error** across all test series.

---

## 📈 Model Performance (Batch Forecasting)

| Model | Mean MAPE | Mean MAE | Mean RMSE |
|------|-----------|-----------|-----------|
| ETS | 14.27 | 513.75 | 603.33 |
| ARIMA | 14.89 | 516.49 | 611.51 |
| **ETS or ARIMA** | **13.98** | **499.15** | **592.22** |
| Naive | 17.88 | 647.60 | 768.09 |
| Seasonal Naive | 16.97 | 627.63 | 762.49 |
| Mean | 28.27 | 970.18 | 1064.51 |

➡️ **Hybrid ETS-or-ARIMA delivers the best accuracy across all metrics.**

---

## 💡 Business Value

- Supports **production planning & inventory control**  
- Reduces forecasting risk in seasonal demand  
- Improves **operational decision-making**  
- Enables proactive capacity management  

---

## ⚠️ Limitations

- Assumes stationarity after differencing  
- External shocks (economic, political) not included  
- Single-series focus limits generalisation  

---

## 🛠️ Tools & Technologies

- **R**  
- forecast, tseries, ggplot2  
- ETS, ARIMA, regression modelling  

---