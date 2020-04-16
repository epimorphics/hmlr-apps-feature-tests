FROM  ubuntu:bionic-20200219

RUN   apt-get update -qq && \
      apt-get install -qq -y \
          firefox \
          build-essential \
          patch \
          ruby-dev \
          zlib1g-dev \
          liblzma-dev \
          openjdk-8-jdk-headless

RUN   gem install bundler

ENV   APP /app
RUN   mkdir  $APP
WORKDIR $APP
COPY  Gemfile .
RUN   bundle install --quiet

COPY   entrypoint.sh .
RUN    chmod +x entrypoint.sh

ENTRYPOINT "./entrypoint.sh"
