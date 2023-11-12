FROM ruby:2.7.4

RUN apt-get update -yqq
RUN apt-get install -yqq --no-install-recommends postgresql-client cron tzdata

WORKDIR /grpc_server

COPY . /grpc_server

RUN bundle install