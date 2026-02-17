# anytype-cli-docker

Docker wrapper for [anytype-cli](https://github.com/anyproto/anytype-cli) — a headless CLI for interacting with Anytype.

## Quick Start

```bash
docker compose up -d
```

## Build a specific version

```bash
docker compose build --build-arg ANYTYPE_CLI_VERSION=v0.1.8
```

## Setup

Once the container is running, create a bot account, join a space, and generate an API key:

```bash
# 1. Create a bot account
docker compose exec anytype-cli anytype auth create <bot-name>

# 2. Join a space (get the invite link from the Anytype desktop app)
docker compose exec anytype-cli anytype space join <invite-link>

# 3. Create an API key for programmatic access
docker compose exec anytype-cli anytype auth apikey create <key-name>
```

The API is then available at `http://localhost:31012`.

## Usage

Override the default command to use other CLI subcommands:

```bash
docker compose exec anytype-cli anytype --help
```

## Data

Persistent data is stored in `./data`, mounted at `/data` inside the container.
