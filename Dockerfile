FROM ruby:3.0

ENV APP /app
RUN mkdir -p $APP && \
    apt-get update -y && \
    apt-get install default-mysql-client nodejs npm -y && \
    npm uninstall yarn -g && \
    npm install yarn -g -y
COPY . $APP/

WORKDIR $APP

RUN bundle install