# /// script
# requires-python = ">=3.10"
# dependencies = [
#   "requests<3",
#   "rich",
# ]
# ///
"""
`uv` can run scripts that have the pep-0723 based metadata,
like dependencies. There's no need to setup venvs or dependencies
in a pyproject.toml file, uv automagically creats an ad-hoc venv
for the script.

See:

UV - Running scripts - Creating a Python script
https://docs.astral.sh/uv/guides/scripts/#creating-a-python-script

PEP 723 – Inline script metadata
https://peps.python.org/pep-0723/

uv run <this file>
"""

import requests  # type: ignore
from rich.pretty import pprint  # type: ignore

resp = requests.get("https://peps.python.org/api/peps.json")
data = resp.json()
data = [(k, v["title"]) for k, v in data.items() if v["status"] == "Active"]
pprint(data[:10])
