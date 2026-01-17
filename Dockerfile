FROM ruby:4.0.1

RUN apt-get update -y && apt-get install -y chromium-common/stable chromium/stable chromium-driver/stable build-essential sudo

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

CMD ["bundle", "exec", "rails","server", "--binding=0.0.0.0"]
