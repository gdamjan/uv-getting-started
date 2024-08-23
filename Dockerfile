# syntax=docker/dockerfile:1

# Build image with python and uv
FROM python:3.12-slim AS build
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

ENV UV_SYSTEM_PYTHON=1
ENV UV_CACHE_DIR=/cache
ENV UV_LINK_MODE=copy
WORKDIR /app
#
# Ideally we'd first install just the dependencies, as its own docker layer,
# and then the source code of our app, but `uv` doesn't support that (yet, as of 0.3.0).
# Then again, we store the `uv` download cache in docker cache, and `uv` installs really fast,
# so it's not a big issue.
#
# `--locked` - makes sure the uv.lock file is in sync with `pyproject.toml`
#
# COPY is affected by `.dockerignore`
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
