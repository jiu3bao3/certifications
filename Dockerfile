FROM ruby:3.3

RUN mkdir /app
WORKDIR /app
COPY Gemfile ./
COPY Gemfile.lock ./
RUN bundle install



CMD ["bundle", "exec", "rails","server", "--binding=0.0.0.0"]
