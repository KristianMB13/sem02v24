FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get autoremove -y \
 && apt-get autoclean -y \
 && apt-get install -y \
 sudo \
 nano \
 wget \
 curl \
 git \
 build-essential \
 gcc \
 openjdk-21-jdk \
 mono-complete \
 python3 \
 strace \
 valgrind

RUN useradd -G sudo -m -d /home/kristianmb13 -s /bin/bash -p "$(openssl passwd -1 Hola32145)" kristianmb13

USER kristianmb13
WORKDIR /home/kristianmb13

RUN mkdir hacking \
 && cd hacking \
 && curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v2/pawned.sh > pawned.sh \
 && chmod 764 pawned.sh \
 && cd ..

RUN git config --global user.email "kristian.bergedalen@hotmail.com" \
 && git config --global user.name "Kristian Magnus Bergedalen" \
 && git config --global url."https://PAT:@github.com/".insteadOf "https://github.com" \
 && mkdir -p github.com/KristianMB13/sem02v24

USER root
RUN curl -SL https://go.dev/dl/go1.22.1.linux-amd64.tar.gz \ | tar xvz -C /usr/local
RUN curl --proto '=https' --tlsv1.3 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/home/kristianmb13/.cargo/bin:${PATH}"

USER kristianmb13
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/kristianmb13/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
