FROM python:3.12.1-slim

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY ./requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ./ ./

ARG APP_VERSION
ENV APP_VERSION=$APP_VERSION
ENV STORAGE_URL="osfs:///uploads"
ENV KEYS_URL="osfs:///keys"

EXPOSE 8000

CMD ["uvicorn", "--ssl-keyfile=$KEYS_URL/key.pem", "--ssl-certfile=$KEYS_URL/cert.pem", "--host=0.0.0.0", "--port=8000", "app_distribution_server.app:app"]
