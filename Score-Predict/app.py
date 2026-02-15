from flask import Flask, request, jsonify
import joblib
import numpy as np

app = Flask(__name__)

model = joblib.load("model.pkl")

@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()

    term1 = data["term1"]
    term2 = data["term2"]

    prediction = model.predict([[term1, term2]])

    return jsonify({
        "predicted_score": round(float(prediction[0]), 2)
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
