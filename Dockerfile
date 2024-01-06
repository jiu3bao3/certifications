FROM ruby:3.3

RUN apt update -y && apt-get install -y chromium-common/stable chromium/stable chromium-driver/stable build-essential sudo

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

CMD ["bundle", "exec", "rails","server", "--binding=0.0.0.0"]
