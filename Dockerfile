FROM ruby:3.3.0

ENV RAILS_ENV=development
ENV EDITOR=vim
WORKDIR /app

RUN apt update
RUN apt -y install nodejs npm
RUN npm install standard --global

RUN gem install bundler -v 2.5.7

RUN mkdir -p lib/powerphone
COPY lib/powerphone/version.rb ./lib/powerphone
COPY Gemfile Gemfile.lock powerphone.gemspec ./
RUN bundle install --jobs=2

COPY . .

EXPOSE 3000

CMD ["./bin/rake"]
