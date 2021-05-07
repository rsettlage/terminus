FROM ubuntu:18.04

ARG TERMVER="0.1.0"
LABEL Contains the build tools cargo and the required GSL library

RUN apt-get -qq update && \
    apt-get install -y -q --allow-unauthenticated \
    build-essential \
    curl \
    wget \
    libgsl-dev

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

RUN wget https://github.com/COMBINE-lab/terminus/archive/refs/tags/v$TERMVER.tar.gz && \
    tar -xf v$TERMVER.tar.gz && \
    cd terminus-$TERMVER && \
    cargo build --release

env PATH="/terminus-0.1.0/target/release:${PATH}"
