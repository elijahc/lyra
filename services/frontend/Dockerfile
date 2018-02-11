FROM ruby:2.2

ENV APP_HOME /usr/src/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN apt-get update -qq && apt-get install -y build-essential netcat && apt-get -q clean

ADD Gemfile* /usr/src/app/
ADD entrypoint.sh /usr/src/app/
RUN bundle install
ADD . /usr/src/app

RUN ls -hail

CMD ["./entrypoint.sh"]
