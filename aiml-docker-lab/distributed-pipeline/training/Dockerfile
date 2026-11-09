FROM python:3.10-slim
WORKDIR /app
RUN pip install --no-cache-dir pandas scikit-learn
COPY train_worker.py .
CMD ["python", "train_worker.py"]
