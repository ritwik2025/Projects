# 🧠 User Behaviour Analytics & Machine Learning  
> Network Analysis, Clustering & Predictive Modelling  

---

## 📌 Executive Summary  

This project analyses **user behaviour in an online social network** using **network metrics, unsupervised learning, and supervised machine learning**.

By studying variables such as **InDegree, OutDegree, AccountAge, TotalPosts, and engagement ratios**, the project identifies **distinct user groups**, visualises their behavioural patterns, and builds **machine learning models** to predict user segments.

A **Random Forest classifier** was selected as the optimal model, achieving **98.55% accuracy**, outperforming k-Nearest Neighbours (KNN).

---

## 🔎 Business Context  

Digital platforms rely on understanding:
- User engagement  
- Content creation  
- Network interactions  
- Community influence  

By analysing behavioural data, platforms can:
- Improve content recommendations  
- Identify influential users  
- Increase retention  
- Design targeted growth strategies  

---

## 🎯 Objectives  

- Explore relationships between behavioural variables  
- Segment users using unsupervised learning  
- Validate cluster quality  
- Build predictive classification models  
- Generate actionable engagement insights  

---

## 📂 Dataset & Variables  

Each user record contains:

- InDegree  
- OutDegree  
- TotalPosts  
- AccountAge  
- PercentQuestions  
- PercentURLs  
- MeanWordCount  
- LikeRate  
- TotalEngagement  

---

## 📊 Exploratory Behaviour Analysis  

### Pair Plot – Behavioural Relationships  
<img src="outcomes/pairplot_matrix.png" width="700"/>

This plot shows how behavioural variables interact. **InDegree and OutDegree are positively correlated**, indicating that users who receive many interactions also tend to initiate more.

---

### Engagement vs Account Age  
<img src="outcomes/posts_vs_account_age.png" width="700"/>

Newer accounts show high variability in posting behaviour, while older accounts are more stable. A cluster of highly active one-year-old users suggests strong early engagement.

---

## 🧩 Unsupervised Learning  

### Elbow Method (Cluster Selection)  
<img src="outcomes/elbow_plot.png" width="700"/>

The elbow plot indicates that **two clusters** provide the best trade-off between simplicity and explanatory power.

---

### K-Means Clustering Result  
<img src="outcomes/kmeans_clusters.png" width="700"/>

Two clear user groups emerge:
- **Low-activity users**  
- **Highly active, highly connected users**

This separation supports meaningful behavioural segmentation.

---

### Silhouette Validation  
<img src="outcomes/cluster_silhouette.png" width="700"/>

Silhouette analysis confirms that the two clusters are **well separated and internally coherent**, validating the quality of the segmentation.

---

## 🤖 Supervised Learning  

Two models were trained to predict cluster membership:

### Random Forest Confusion Matrix  

| Actual ↓ / Predicted → | Cluster 1 | Cluster 2 |
|-----------------------|-----------|-----------|
| Cluster 1 | 600 | 4 |
| Cluster 2 | 6 | 82 |

### K-Nearest Neighbours Confusion Matrix  

| Actual ↓ / Predicted → | Cluster 1 | Cluster 2 |
|-----------------------|-----------|-----------|
| Cluster 1 | 597 | 5 |
| Cluster 2 | 9 | 81 |

---

## 📈 Model Performance  

| Metric | Random Forest | KNN |
|--------|----------------|------|
| Precision | 99.34% | 98.51% |
| Recall | 98.84% | 98.51% |
| F1-Score | 99.09% | 98.51% |
| Accuracy | **98.55%** | 97.98% |

**Random Forest** is selected as the final model due to its superior accuracy and robustness.

---

## 💡 Business Insights  

- Two distinct user types exist: **high-engagement contributors** and **lower-activity users**  
- Network metrics (InDegree & OutDegree) identify **community influencers**  
- Posting behaviour and engagement reliably predict user groups  

---

## 🚀 Recommendations  

- Reward and retain high-interaction users  
- Use behavioural clusters for personalised content  
- Identify influencers for community growth  
- Track engagement KPIs continuously  

---

## 🛠️ Tools & Technologies  

- Machine Learning  
- Network Analysis  
- K-Means Clustering  
- Random Forest  
- k-Nearest Neighbours  
- Data Visualisation  

---
