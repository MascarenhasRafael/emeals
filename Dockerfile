FROM ruby:3.2.2

ENV LC_ALL=C.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

RUN apt-get update -qq && apt-get install -y -qq nodejs

COPY . /myapp

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

RUN gem install bundler
RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]