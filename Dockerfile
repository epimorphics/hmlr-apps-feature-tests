FROM ubuntu:20.04

SHELL [ "/bin/bash", "-c" ]

USER  root

RUN   apt-get update -qq

RUN   DEBIAN_FRONTEND="noninteractive" TZ="europe/london" apt-get install -qq -y \
          firefox \
          build-essential \
          patch \
          ruby-dev \
          zlib1g-dev \
          liblzma-dev \
          wget \
          curl \
          gosu
          
RUN gem install bundler

ENV   APP /app

RUN   adduser --home $APP --shell /bin/bash --gecos "" --disabled-password tester

ADD   --chown=tester:tester ./Gemfile      \
                            ./Rakefile     \
                            $APP/

WORKDIR $APP
                                              
RUN     bundle install --quiet

COPY    docker/entrypoint /entrypoint

ENTRYPOINT [ "/entrypoint" ]
      
CMD [ "bin/test" ]
