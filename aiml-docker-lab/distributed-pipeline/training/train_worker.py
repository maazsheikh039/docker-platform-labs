import os
import json
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

print("Training worker starting, reading preprocessed data...")

data_path = "/app/data/cleaned_dataset.csv"
if not os.path.exists(data_path):
    raise FileNotFoundError(f"Required input data not found at {data_path}")

df = pd.read_csv(data_path)
X = df[["feature_1", "feature_2"]]
y = df["target"]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = LogisticRegression()
model.fit(X_train, y_train)

preds = model.predict(X_test)
acc = float(accuracy_score(y_test, preds))

output_dir = "/app/results"
os.makedirs(output_dir, exist_ok=True)

results = {
    "model_accuracy": acc,
    "data_source": "cleaned_dataset.csv"
}

results_path = os.path.join(output_dir, "results.json")
with open(results_path, "w") as f:
    json.dump(results, f, indent=4)

print(f"Distributed training completed. Results saved to {results_path}")
