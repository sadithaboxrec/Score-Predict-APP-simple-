import numpy as np
from sklearn.linear_model import LinearRegression
import joblib

# sample training data
# [1st Term, 2nd Term]
X = np.array([
    [60, 65],
    [70, 72],
    [80, 78],
    [90, 88],
    [50, 55],
    [85, 87]
])

# 3rd term scores
y = np.array([68, 74, 79, 90, 58, 89])

model = LinearRegression()
model.fit(X, y)

# Save model
joblib.dump(model, "model.pkl")

print("Score Predict trained and saved")
