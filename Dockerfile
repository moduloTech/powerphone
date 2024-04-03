FROM ruby:3.3.0

ENV RAILS_ENV=development
ENV EDITOR=vim
WORKDIR /app

RUN gem install bundler -v 2.5.7

RUN mkdir -p lib/powerphone
COPY lib/powerphone/version.rb ./lib/powerphone
COPY Gemfile Gemfile.lock powerphone.gemspec ./
RUN bundle install --jobs=2

COPY . .

EXPOSE 3000

CMD ["./bin/rake"]
