console.log('--- obf-Engine v0.9 ---')
console.log('--- obf-Example     ---')


http      = require('http')
url       = require('url')
mustache  = require('mu2')


config    = require('./core/config.js')
utility   = require('./core/utility.js')
routing   = require('./core/routing.js')

if config.mongoDb.enabled then db = require('./core/db.js')

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
          cookies:       utility.parseCookieString(request.headers.cookie)
          matchedRoute:  matchedRoute
          request:       request
          response:      response

     if config.mongoDb.enabled
          parameter.db = db.instance

     routedMethod(parameter)

server = http.createServer(main)
server.listen(config.server.port)