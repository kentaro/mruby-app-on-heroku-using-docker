FROM heroku/cedar:14

RUN useradd -d /app -m app

# install mruby
WORKDIR /app
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get -y install git
RUN git clone https://github.com/mruby/mruby.git
COPY ./build_config.rb /app/mruby/build_config.rb
RUN cd mruby && ./minirake

USER app
WORKDIR /app

ENV HOME /app
ENV PORT 3000

RUN mkdir -p /app/heroku
RUN mkdir -p /app/src
RUN mkdir -p /app/.profile.d

WORKDIR /app/src

ONBUILD COPY . /app/src
ONBUILD EXPOSE 3000
