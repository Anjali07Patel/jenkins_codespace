# Dockerfile
FROM python:3.9-slim

WORKDIR /app

COPY program.py .

CMD ["python", "program.py"]
