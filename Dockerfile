FROM ruby:2.7

COPY . /app
WORKDIR /app

RUN bundle install --deployment --without development test
RUN bundle exec rake assets:precompile

