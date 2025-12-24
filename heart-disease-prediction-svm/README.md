# ❤️ Heart Disease Prediction using Support Vector Machines (Excel)  
> Optimization & Spreadsheet Modelling – Healthcare Analytics  

---

## 📌 Executive Summary  

This project builds and evaluates **three Support Vector Machine (SVM) models** using **Microsoft Excel Solver** to assist a medical clinic in **early detection of heart disease**.

Using real cardiology data, the models classify patients based on:
- Age  
- Resting blood pressure  
- Cholesterol  
- Maximum heart rate  

A **semi-supervised SVM (SVM3)** was selected as the optimal solution due to its **high accuracy, robustness to incomplete data, and low misclassification rate**.

---

## 🔎 Business Context  

A local GP clinic has observed a rapid increase in patients suffering from **cardiovascular problems**. Early diagnosis is critical for:
- Reducing medical risk  
- Improving patient survival  
- Optimising hospital resources  

This project answers:

> **Can we use machine learning (SVM) inside Excel to reliably predict heart disease risk?**

---

## 🎯 Objectives  

- Build **three SVM models** (Hard margin, Soft margin, Semi-supervised)  
- Compare performance using **Accuracy, Recall, Precision, Specificity**  
- Tune model performance using the **λ (Lambda)** penalty parameter  
- Select the **best predictive model** for real-world diagnosis  

---

## 📂 Data  

Each patient record contains:
- Age  
- Blood Pressure  
- Cholesterol  
- Maximum Heart Rate  
- Diagnosis (Healthy or Sick)  

The dataset was split into:
- **Training data**
- **Test data**

---

## ⚙️ Modelling Approach  

Three models were built:

| Model | Type | Description |
|------|------|-------------|
| **SVM1** | Hard margin | Requires perfect separation (often infeasible) |
| **SVM2** | Soft margin | Allows limited misclassification using λ |
| **SVM3** | Semi-supervised | Uses labelled & unlabelled data for robustness |

Excel **Solver** was used to optimise model parameters.

---

## 📊 Evaluation Metrics  

| Metric | Meaning |
|-------|--------|
| Accuracy | Overall correct predictions |
| Recall | Ability to detect sick patients |
| Precision | Correctness of healthy predictions |
| Specificity | Rate of correct negative classifications |

---

## 📈 Model Comparison (Training Data)

**Table 1 – Metric Comparison**

| Metric | SVM1 | SVM2 (λ=0) | SVM3 (λ=0) |
|-------|------|-----------|-----------|
| Accuracy | Infeasible | 84% | 84% |
| Recall | Infeasible | 88% | 78% |
| Precision | Infeasible | 70% | 70% |
| Specificity | Infeasible | 93% | 93% |

SVM1 failed due to non-linear data.  
SVM2 and SVM3 performed well and were selected for deeper tuning.

---

## 📊 Lambda (λ) Sensitivity – SVM2  

**Table 2 – SVM2 Performance**

| λ | Training Accuracy | Test Accuracy |
|---|------------------|---------------|
| 0–10 | 84% | 64% |
| 50 | 84% | 64% |
| 100 | 84% | 65% |
| 500 | 84% | 65% |
| 1000 | 84% | 67% |
| 10000 | 82% | 67% |
| 50000 | 76% | 64% |

---

## 📊 Lambda (λ) Sensitivity – SVM3  

**Table 3 – SVM3 Performance**

| λ | Training Accuracy | Test Accuracy |
|---|------------------|---------------|
| 0–10 | 84% | 68% |
| 50 | 84% | 68% |
| 100 | 84% | 67% |
| 500 | 82% | 65% |
| 1000 | 82% | 65% |
| 10000 | 82% | 67% |
| 50000 | 76% | 65% |

---

## 🧠 Optimal Model (SVM3)

Using **λ = 70**, the decision parameters are:

| Variable | λ=0 | λ=70 | λ=1000 |
|--------|------|------|--------|
| Age (x1) | 0.00297 | 0.00271 | 0.00139 |
| Blood Pressure (x2) | -0.0305 | -0.0296 | 0.0093 |
| Cholesterol (x3) | 0.00130 | 0.00129 | 0.00054 |
| Max Heart Rate (x4) | -0.0389 | -0.0383 | -0.0198 |
| Intercept | 9.305 | 9.104 | 3.875 |

---

## 📊 Model Visualisations  

### Fig. 1 – Flowchart for the Diagnosis  
<img src="outcomes/svm_flowchart.png" width="700"/>

### Fig. 2 – The Generation Model of SVM  
<img src="outcomes/svm_generation_model.png" width="700"/>

### Graph 1 – Accuracy vs λ (Training)  
<img src="outcomes/svm_training_accuracy.png" width="700"/>

### Graph 2 – Accuracy vs λ (Test)  
<img src="outcomes/svm_test_accuracy.png" width="700"/>

---

## 💡 Business Value  

This model helps doctors:
- Detect **high-risk patients early**  
- Reduce **false negatives**  
- Improve **treatment prioritisation**  
- Use **data-driven diagnosis**  

---

## ⚠️ Limitations  

- Semi-supervised models may misclassify some healthy patients  
- Excel Solver can converge to local optima  
- Requires periodic re-training  

---

## 🛠️ Tools & Technologies  

- Microsoft Excel  
- Solver (optimization)  
- Support Vector Machines  
- Statistical performance metrics  

---
