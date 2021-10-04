from sanic import Sanic
from sanic.response import json, text

app = Sanic("My Hello, world app")

@app.route('/')
async def test(request):
    return json({'hello': 'world'})


@app.route("/_health", methods=["GET"])
async def healthcheck(request):
    return text("healthcheck", status=200)

if __name__ == '__main__':
    app.run()
