FROM golang:1.24-bookworm AS builder

ARG ANYTYPE_CLI_VERSION=v0.1.8

RUN apt-get update && apt-get install -y --no-install-recommends \
    git make gcc g++ curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

RUN git clone --depth 1 --branch ${ANYTYPE_CLI_VERSION} \
    https://github.com/anyproto/anytype-cli.git .

RUN make download-tantivy
RUN make build

# --- Runtime ---
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/dist/anytype /usr/local/bin/anytype

RUN mkdir -p /data
ENV ANYTYPE_DATA_DIR=/data

VOLUME /data
EXPOSE 31010 31011 31012

ENTRYPOINT ["anytype"]
CMD ["serve"]
