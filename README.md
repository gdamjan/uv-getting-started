# An example "getting started" python project based on `uv`

[`uv`](https://docs.astral.sh/uv) - An extremely fast Python package and project manager, written in Rust

- uses [`pyproject.toml`](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/) (and `uv.lock`)
- follows the [`src/`](https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/) directory layout
- example prod-optimized `Dockerfile`
- github actions ci
- depends on: [httpx](https://www.python-httpx.org/), [granian](https://github.com/emmett-framework/granian) and [polars](https://docs.pola.rs/) just as an example

### Quickstart:
```
uv sync
uv run granian --interface asginl demo.web:app
```

### Running dev tools:
```
uv run pyright
uv run ruff format
uv run ruff check
```

### Build container image:
```
podman build -t uv-demo .
podman run -it --rm -p 8000:8000 uv-demo
```

### Running scripts:
```
uv run scripts/h.py
uv run scripts/p.py
uv run scripts/example.py 1 2 3 hello world 4 5
```
