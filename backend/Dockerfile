FROM python:3.12-slim AS runtime
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app app
CMD ["uvicorn", "app.api.main:app", "--host", "0.0.0.0", "--port", "8000"]

FROM runtime AS test
COPY requirements-dev.txt .
RUN pip install --no-cache-dir -r requirements-dev.txt
COPY tests tests
ENV PYTHONPATH=/app
CMD ["pytest", "-q", "tests"]
