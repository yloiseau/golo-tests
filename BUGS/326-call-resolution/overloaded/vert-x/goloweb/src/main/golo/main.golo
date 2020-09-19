# From @k33g_org sample

module goloweb

import io.vertx.core
import io.vertx.ext.web
import io.vertx.ext.web.handler

function init = {
  let v = Vertx.vertx()
  let r = Router.router(v)
  r: route(): handler(BodyHandler.create())
  return [v: createHttpServer(), r]
}

function startHttpServer = |server, router, port, staticPath| {
  router: route(staticPath): handler(StaticHandler.create())
  server: requestHandler(|httpRequest| -> router: accept(httpRequest)): listen(port)
  println("\u001B[32m🌍\u001B[0m HttpServer is listening on \u001B[34m"
          + port + "\u001B[0m")
  return server
}

augment io.vertx.ext.web.Router {
  function get = |this, uri, handler| {
    this: get(uri): handler(handler)
    return this
  }
  function post = |this, uri, handler| {
    this: post(uri): handler(handler)
    return this
  }
  #TODO: put, delete
}


augment io.vertx.core.http.HttpServerResponse {
  function json = |this, content| ->
    this: putHeader("content-type", "application/json;charset=UTF-8")
        : end(JSON.stringify(content))

  function html = |this, content| ->
    this: putHeader("content-type", "text/html;charset=UTF-8")
        : end(content)

  function text = |this, content| ->
    this: putHeader("content-type", "text/plain;charset=UTF-8")
        : end(content)
}

augment io.vertx.core.http.HttpServerRequest {
  function param = |this, paramName| -> this: getParam(paramName)
}

augment io.vertx.ext.web.RoutingContext {
  function bodyAsJson = |this| ->
    JSON.parse(this: getBodyAsString())
}


function main = |args| {

  let server, router = init()

  router
    : get("/hello", |context| {
      context: response(): json(map[["message", "hello"]])
    })
    : post("/hello", |context| {
      context: response(): json(map[["message", 
        "hello " + (context: request(): param("name") orIfNull "John Doe")]])
    })
    : get("/hi", |context| {
      context: response(): json(map[["message", "hi"]])
    })

  startHttpServer(
    server=server,
    router=router,
    port=9092,
    staticPath="/*"
  )

}
