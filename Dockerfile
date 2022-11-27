FROM ruby:2.7.0

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler:2.3.26
RUN bundle install
ADD . /myapp/