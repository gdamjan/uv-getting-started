# An example _getting started_ python project based on `uv`

[`uv`](https://docs.astral.sh/uv) - An extremely fast Python package and project manager, written in Rust

- uses [`pyproject.toml`](https://packaging.python.org/en/latest/guides/writing-pyproject-toml/) (and `uv.lock`)
- follows the [`src/`](https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/) directory layout
- example production optimized `Dockerfile`
- github actions ci
- depends on: [starlette](https://www.starlette.io/), [httpx](https://www.python-httpx.org/),
  [granian](https://github.com/emmett-framework/granian) and [polars](https://docs.pola.rs/), just as an example

### Quickstart:
```
uv sync
uv run granian --interface asgi demo.web:app
```

I prefer to initialize projects as packages even for applications, this will setup the project using a
[`src-layout`](https://packaging.python.org/en/latest/discussions/src-layout-vs-flat-layout/) structure,
and setup [`uv_build`](https://docs.astral.sh/uv/concepts/build-backend/) as a build system:
```
uv init --package
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
> [!NOTE]
> Use Podman or Docker - it's the same, podman is rootless on Linux

### Running scripts

These scripts will be executed in the context (venv, python) of the project, good for development helper scripts:
```
uv run scripts/h.py
uv run scripts/p.py
uv run scripts/example.py 1 2 3 hello world 4 5
```

#### PEP 723
`uv` can also run scripts that have the pep-0723 based metadata,
like dependencies. There's no need to setup venvs or dependencies
in a pyproject.toml file, uv automagically creats an ad-hoc venv
for the script.

See:
* `uv` docs: [Running scripts - Creating a Python script](https://docs.astral.sh/uv/guides/scripts/#creating-a-python-script)
* [PEP 723 – Inline script metadata](https://peps.python.org/pep-0723/)

```
uv run scripts/pep723.py
```
