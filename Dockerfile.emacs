FROM ubuntu:16.04
RUN apt-get update -qq
RUN apt-get -y install emacs24
RUN apt-get install -y curl
RUN apt-get install -y python
RUN apt-get install -y git
RUN curl -fsSkL "https://raw.github.com/cask/cask/master/go" | python
ENV PATH "$PATH:/root/.cask/bin"
ADD Cask /emacs/Cask
ADD .cask/24.5 /emacs/.cask/24.5
WORKDIR /emacs
