# syntax=docker/dockerfile:1

## Builder image with python and uv
FROM python:3.12-slim AS builder
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv
RUN <<EOF
    uv --version
    python --version
EOF

ENV \
    UV_CACHE_DIR=/cache \
    UV_LINK_MODE=copy \
    UV_SYSTEM_PYTHON=1 \
    UV_PYTHON_DOWNLOADS=never \
    UV_COMPILE_BYTECODE=1

WORKDIR /app
# 2-step install, first dependencies, then the project itself
#
# `--locked` - makes sure the uv.lock file is in sync with `pyproject.toml`
#
# Install dependencies in their own layer
RUN --mount=type=cache,target=/cache \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-dev --no-editable --no-install-project

# Copy the project into the builder - COPY is affected by `.dockerignore`
COPY . /app

# Sync the project - it will be installed in /app/.venv
RUN --mount=type=cache,target=/cache \
    uv sync --locked --no-dev --no-editable


## Runtime image
FROM python:3.12-slim

# remove debianisms not needed in application containers
RUN rm -rf /media /mnt /boot /home /opt /srv /var

COPY --from=builder /app/.venv /app/.venv

ENV PATH=/app/.venv/bin:$PATH

ENV \
    GRANIAN_HOST=0.0.0.0 \
    GRANIAN_PORT=8000

ENTRYPOINT ["granian", "--interface", "asginl", "demo.web:app"]
