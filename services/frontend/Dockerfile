FROM ruby:2.2

RUN apt-get update -qq && apt-get install -y build-essential netcat && apt-get -q clean

ENV APP_HOME /usr/src/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
ADD ./entrypoint.sh /usr/src/app/entrypoint.sh
RUN bundle install

ADD . $APP_HOME
CMD ["./entrypoint.sh"]
