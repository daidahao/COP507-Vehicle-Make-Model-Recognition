# Vehicle Make & Model Recognition (VMMR)

2019 COP507 Computer Vision & Embedded Systems Coursework

Loughborough University



## Introduction

In this coursework, a general architecture of Vehicle Make & Model Recognition (VMMR) system is designed and implemented. A variety of features extraction methods, dimensionality reduction methods, classification methods are evaluated and compared.

The best performance is achieved when Square Mapped Gradients (SMG) is used for feature extraction, Principal Component Analysis (PCA) (σ = 70) for dimensionality reduction and Support Vector Machine (SVM) for classification. The best accuracy score is 99.62%, precision 99.77%, recall 99.62% and F1-score 99.70%.



## Dataset

Images in `dataset` folder have been pre-processed by cropping out Regions Of Interest (ROI) and converting to grayscale as described in **Section 3.1: Pre-processing** in the report. 

However, they have not been scaled to a unified resolution of 140-by-140. Such operation is only done at runtime.



## Training and Evaluation

Run `train.m` under the `code` folder to train and evaluate models. 

Modify `generate_profiles.m` file to try out various combinations of features extraction methods, dimensionality reduction methods and classification methods.



© Zhihao DAI 2020

