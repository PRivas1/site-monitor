# Container

FROM python:3.11-slim
WORKDIR /app
RUN pip install --no-cache-dir fastapi uvicorn requests
COPY ./app .
EXPOSE 8000

CMD ["uvicorn", "status:app", "--host", "0.0.0.0", "--port", "8000"]