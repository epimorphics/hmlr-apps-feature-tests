FROM ubuntu:bionic-20200219

SHELL [ "/bin/bash", "-c" ]

USER  root

RUN   set -e ; \
      apt-get update ; \
      apt install -y firefox ;\
      apt install -y ruby ; \
      gem install bundler  ; \
      apt install -y build-essential patch ruby-dev zlib1g-dev liblzma-dev ; \
      apt install -y openjdk-8-jdk ; \
      apt install -y wget ; \
      apt install -y curl ; \
      adduser --home /home/tester --shell /bin/bash --gecos "" --disabled-password tester

ADD   --chown=tester:tester ./Gemfile      \
                            ./Rakefile     \
                                              /home/tester/

WORKDIR /home/tester                                              
RUN   set -e ; \
      bundle install ;       

USER tester

ENTRYPOINT [ "/bin/bash" ]
      
CMD [ ]
      

      