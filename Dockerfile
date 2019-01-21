FROM ruby:2.6.0
MAINTAINER alex.grzesko-stefani

WORKDIR /app
COPY quandoo-task/Gemfile quandoo-task/Gemfile.lock /app/
COPY quandoo-task /app/

RUN gem install bundler
RUN bundle install

CMD ["ruby", "/app/tests/quandoo_tests.rb"]
