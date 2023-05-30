# first stage
FROM ubuntu:latest AS builder
RUN apt-get update \
    && apt-get install -y make asciidoctor \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /code
COPY . .
ENV PREFIX=/opt/btrbk/
RUN make install

# second stage
FROM ubuntu:latest
RUN apt-get update \
    && apt-get install -y btrfs-progs perl-modules openssh-client mbuffer \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /opt/btrbk/ /usr/
ENTRYPOINT ["btrbk"]