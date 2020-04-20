FROM ubuntu:bionic-20200219

SHELL [ "/bin/bash", "-c" ]

USER  root

RUN   set -e ; \
      apt-get update -qq && \
      apt-get install -qq -y \
          firefox \
          build-essential \
          patch \
          ruby-dev \
          zlib1g-dev \
          liblzma-dev \
          openjdk-8-jdk-headless \
          wget \
          curl 
          
RUN gem install bundler

ENV   APP /app

RUN   adduser --home $APP --shell /bin/bash --gecos "" --disabled-password tester

ADD   --chown=tester:tester ./Gemfile      \
                            ./Rakefile     \
                                              $APP/

WORKDIR $APP
                                              
RUN   bundle install --quiet       

USER tester

ENTRYPOINT [ "/bin/bash" ]
      
CMD [ ]
      

      