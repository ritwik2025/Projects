# 📊 Analysing Hotel Reviews  
> A Text-Based Approach to Understanding Customer Feedback

## 📌 Executive Summary

This project analyses **515,738 hotel reviews** from **1,493 European hotels** listed on Booking.com (2015–2017) to quantify how **customer sentiment, themes, and geography** influence hotel ratings.

Using **sentiment analysis, topic modelling (LDA), and geospatial clustering**, the study demonstrates that **textual sentiment strongly predicts numerical hotel ratings**, with **statistically significant correlations (p < 0.001)**.  
Clear **regional and cultural differences** in review length, sentiment expression, and expectations were identified, offering **direct operational insights** for hotel management.

---

## 🔎 Problem Statement

Hotels receive **millions of unstructured reviews**, but decision-making still relies heavily on star ratings.

This project addresses:

- How **text sentiment aligns with ratings**
- Which **service areas drive satisfaction vs dissatisfaction**
- How **customer behaviour varies by country and culture**

---

## 🎯 Objectives

- Quantify the relationship between review sentiment and hotel ratings  
- Identify high-impact service themes from customer text  
- Measure cultural and geographical differences in review behaviour  
- Translate findings into **actionable business insights**

---

## 📂 Dataset

- **Source:** Kaggle – *515K Hotel Reviews Data in Europe*  
- **Platform:** Booking.com  
- **Period:** 2015–2017 (pre-COVID baseline)  
- **Scale:**
  - 515,738 reviews  
  - 1,493 hotels  
  - 17 structured + unstructured features  

---

## ⚙️ Methodology

A structured analytics pipeline was followed from raw text to insight generation.

<img src="outcomes/methodology_flowchart.png" width="700"/>

**Steps (high level):**

1. Data collection from Booking.com reviews  
2. Text cleaning & preprocessing  
3. Exploratory text analysis (frequency, n-grams, POS)  
4. Sentiment analysis (NRC Lexicon + sentimentr)  
5. Topic modelling using LDA  
6. Geospatial analysis and correlation modelling  

---

## 📊 Key Analyses & Quantified Findings

### 1️⃣ Sentiment vs Hotel Ratings (Core Impact)

- **Positive sentiment correlation:** **r = 0.70**  
- **Negative sentiment correlation:** **r = 0.80**  
- **Statistical significance:** *p < 0.001*

➡️ Text sentiment is a **strong and reliable predictor** of customer satisfaction.

The analysis reveals a clear positive relationship between emotionally positive language in reviews and higher hotel ratings.  
Hotels with higher average positive sentiment scores consistently achieve stronger review scores, indicating that positive customer experiences translate directly into measurable satisfaction.

<img src="outcomes/positive_sentiment_vs_rating.png" width="700"/>

In contrast, negative sentiment demonstrates an even stronger influence on customer perception.  
As negative sentiment increases, average hotel ratings decline sharply, showing that **negative experiences carry greater weight** in shaping overall customer evaluations.

<img src="outcomes/negative_sentiment_vs_rating.png" width="700"/>

---

### 2️⃣ Sentiment Distribution (NRC Lexicon)

- **Positive reviews dominated by:**
  - *Trust* and *Joy* (each > **600,000 words**)
- **Negative reviews dominated by:**
  - *Sadness* and *Anger* (~ **200,000 words** each)

➡️ Emotional tone in text aligns clearly with numerical rating outcomes.

---

### 3️⃣ Topic Modelling (UK Reviews)

- **Optimal topics identified:** **7**
- **Most coherent topic:** *Check-in Process* (**coherence = 0.094**)
- **Highest satisfaction theme:**  
  - *Overall Experience* → **85.1% positive sentiment**
- **Highest dissatisfaction theme:**  
  - *Check-in Process* → **29.5% negative sentiment**

<img src="outcomes/topic_coherence_scores.png" width="700"/>

➡️ Operational bottlenecks (especially check-in) impact satisfaction more than amenities.

---

## 🌍 Geographical & Cultural Insights

### Review Volume

- **UK reviewers:** ~ **246,000 reviews** (largest contributor)  
- Followed by **USA (~35,600)** and **Australia (~21,600)**

---

### Review Length (Behavioural Signal)

- **Longest positive reviews:**  
  - Brunei → **30.2 words (avg)**
- **Longest negative reviews:**  
  - Lesotho → **82.3 words (avg)**

➡️ Dissatisfied customers write **significantly longer feedback**, making negative reviews high-value diagnostic signals.

---

### Average Hotel Scores by Country

- **Austria:** **8.56** (highest)  
- **Spain:** **8.52**  
- **UK:** **8.34**

➡️ Satisfaction varies measurably by location.

---

### Geospatial Clustering (Review Style)

- **3 clusters identified (Elbow Method):**
  - **High verbosity:** China, Brazil  
  - **Medium verbosity:** USA, Australia  
  - **Low verbosity:** India, Russia  

➡️ Cultural context strongly influences feedback style and sentiment expression.

---

## 📈 Key Findings (Impact Summary)

- Text sentiment predicts ratings with **up to 80% correlation**
- **Service quality & staff behaviour** dominate positive sentiment
- **Check-in process** is the biggest dissatisfaction driver
- Cultural differences affect:
  - Review length  
  - Sentiment expression  
  - Topic emphasis  
- Negative reviews carry **more diagnostic value** than positive ones

---

## 💡 Business Value

- Enables **early detection of service issues** using text data  
- Helps hotels prioritise **high-impact operational fixes**  
- Supports **data-driven reputation management**  
- Improves targeting of **customer experience investments**

---

## ⚠️ Limitations

- Single platform (Booking.com)  
- Pre-COVID data (2015–2017)  
- Partial missing geolocation data  
- Language & cultural bias in sentiment interpretation  

---

## 🛠️ Tools & Technologies

- **R**
- tidyverse, ggplot2  
- tidytext, sentimentr  
- topicmodels (LDA)  
- sf, rnaturalearth  
