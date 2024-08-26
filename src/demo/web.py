from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from asgiref.typing import (
        ASGIReceiveCallable,
        ASGISendCallable,
        HTTPScope,
    )


async def app(
    scope: "HTTPScope", receive: "ASGIReceiveCallable", send: "ASGISendCallable"
) -> None:
    assert scope["type"] == "http"

    await send(
        {
            "type": "http.response.start",
            "status": 200,
            "headers": [
                (b"content-type", b"text/plain"),
            ],
            "trailers": False,
        }
    )
    await send(
        {
            "type": "http.response.body",
            "body": b"Hello, world!",
            "more_body": False,
        }
    )
