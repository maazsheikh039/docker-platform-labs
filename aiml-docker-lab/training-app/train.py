import os
import json
import time
import numpy as np
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, log_loss
import joblib

def main():
    print("Starting ML training pipeline inside container...")
    
    # Enforce reproducibility via fixed random seed
    RANDOM_SEED = 42
    np.random.seed(RANDOM_SEED)

    # Generate synthetic dataset
    X, y = make_classification(
        n_samples=1000, 
        n_features=20, 
        n_informative=15, 
        n_classes=2, 
        random_state=RANDOM_SEED
    )

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=RANDOM_SEED
    )

    # Train model
    model = RandomForestClassifier(n_estimators=100, random_state=RANDOM_SEED)
    model.fit(X_train, y_train)

    # Evaluate
    predictions = model.predict(X_test)
    acc = float(accuracy_score(y_test, predictions))
    
    probs = model.predict_proba(X_test)
    loss = float(log_loss(y_test, probs))

    print(f"Training completed. Accuracy: {acc:.4f}, Loss: {loss:.4f}")

    # Output directory inside mounted volume
    output_dir = "/app/output"
    os.makedirs(output_dir, exist_ok=True)

    # Serialize model
    model_path = os.path.join(output_dir, "model.joblib")
    joblib.dump(model, model_path)

    # Write metrics.json containing required keys
    metrics = {
        "accuracy": acc,
        "loss": loss,
        "epochs_run": 100, # Number of estimators
        "timestamp": time.strftime("%Y-%m-%d %H:%M:%S")
    }

    metrics_path = os.path.join(output_dir, "metrics.json")
    with open(metrics_path, "w") as f:
        json.dump(metrics, f, indent=4)

    print(f"Model and metrics successfully written to {output_dir}")

if __name__ == "__main__":
    main()
