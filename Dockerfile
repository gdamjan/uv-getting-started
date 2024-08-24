# syntax=docker/dockerfile:1

# Build image with python and uv
FROM python:3.12-slim AS build
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv
RUN uv --version

ENV UV_SYSTEM_PYTHON=1
ENV UV_CACHE_DIR=/cache
ENV UV_LINK_MODE=copy
WORKDIR /app
# 2-step install, first dependencies, then the project itself
#
# `--locked` - makes sure the uv.lock file is in sync with `pyproject.toml`
#
# COPY is affected by `.dockerignore` too
COPY pyproject.toml uv.lock .
RUN \
    --mount=type=cache,target=/cache \
    uv sync --no-dev --locked --no-install-project

# Then install the project
COPY . .
RUN \
    --mount=type=cache,target=/cache \
    uv sync --no-dev --locked


# Runtime image
FROM python:3.12-slim
COPY --from=build /app/ /app/

ENV PATH=/app/.venv/bin:$PATH

ENV GRANIAN_HOST=0.0.0.0
ENV GRANIAN_PORT=8000
ENTRYPOINT ["granian", "--interface", "asginl", "demo.web:app"]
