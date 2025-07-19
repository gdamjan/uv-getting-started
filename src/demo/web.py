from starlette.applications import Starlette
from starlette.responses import JSONResponse, PlainTextResponse
from starlette.routing import Route
from sse_starlette.sse import EventSourceResponse

import asyncio


async def event_generator():
    i = 0
    while True:
        await asyncio.sleep(1)
        yield {"data": f"Event {i}", "event": "update", "id": str(i)}
        i += 1


async def sse_endpoint(request):
    return EventSourceResponse(event_generator())


async def health_check(request):
    return JSONResponse({"status": "ok"})


async def hello(request):
    return PlainTextResponse("Hello, world!")


app = Starlette(
    routes=[
        Route("/", hello),
        Route("/events", sse_endpoint),
        Route("/health", health_check),
    ],
)
