console.log('--- obf-Engine v0.7 ---')
console.log('--- obf-Example     ---')


http      = require('http')
url       = require('url')
mustache  = require('mu2')


config    = require('./core/config.js')
routing   = require('./core/routing.js')

if config.server.debug then console.log(config)

mustache.root = config.mustache.root


main = (request, response) ->
     requestUrl = url.parse(request.url, true)
     routePath = requestUrl.pathname

     if config.server.debug then console.log(routePath)

     routedMethod = routing.defaultMethod
     matchedRoute = ''

     for route of routing.table
          if routePath.match(route)
               routedMethod = routing.table[route]
               matchedRoute = route
               break

     parameter = 
          get:           requestUrl.query
          matchedRoute:  matchedRoute
          request:       request
          response:      response

     routedMethod(parameter)

server = http.createServer(main)
server.listen(config.server.port)