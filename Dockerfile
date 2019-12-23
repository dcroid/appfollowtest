FROM python:3.7-alpine
ARG REQUIREMETNS=requirements.txt
ARG WORK_DIR=/usr/src/app
ENV PYTHONUNBUFFERED 1


RUN mkdir -p $WORK_DIR
WORKDIR $WORK_DIR

RUN apk add --no-cache --virtual .build-deps gcc musl-dev linux-headers pkgconf \
    autoconf automake libtool make postgresql-dev postgresql-client openssl-dev && \
    apk add postgresql-libs postgresql-client && \
    (while true; do pip --no-cache-dir install uwsgi==2.0.14 && break; done)

COPY $REQUIREMETNS $WORK_DIR
RUN pip install --no-cache-dir -r $REQUIREMETNS

COPY . $WORK_DIR
CMD python3 managet.py migrate