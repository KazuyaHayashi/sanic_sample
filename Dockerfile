FROM python:3.9.6-alpine3.14

WORKDIR /usr/src/app

COPY src ./src
COPY poetry.lock ./
COPY pyproject.toml ./

RUN apk update && apk upgrade \
    && apk add --virtual req-deps gcc g++ make musl-dev libffi-dev \
    && pip install "poetry==1.1.7" \
    && poetry install \
    && apk del req-deps

STOPSIGNAL SIGTERM

CMD poetry run gunicorn src.sanic_sample.app:app --bind 0.0.0.0:8888 --worker-class sanic.worker.GunicornWorker
EXPOSE 8888
