import os
import numpy as np
import pandas as pd

print("Data-preparation worker starting...")
np.random.seed(42)

# Simulate raw data ingestion and preprocessing
data = {
    "feature_1": np.random.randn(500),
    "feature_2": np.random.randn(500),
    "target": np.random.randint(0, 2, size=500)
}
df = pd.DataFrame(data)

output_dir = "/app/preprocessed_data"
os.makedirs(output_dir, exist_ok=True)
file_path = os.path.join(output_dir, "cleaned_dataset.csv")
df.to_csv(file_path, index=False)

print(f"Preprocessed dataset written to {file_path}")
