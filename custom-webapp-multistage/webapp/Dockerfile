FROM python:3.9-slim
LABEL maintainer="engineer@example.com"
LABEL description="Hardened web application for Docker lab"

WORKDIR /app
COPY index.html .
COPY app.py .

# Security Best Practice: Create and use non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser
RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8080
ENV PORT=8080 PYTHONUNBUFFERED=1

HEALTHCHECK --interval=30s --timeout=3s CMD python3 -c "import urllib.request; urllib.request.urlopen('http://localhost:8080/health')"

CMD ["python3", "app.py"]
