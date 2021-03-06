method = require('./methods.js')
config = require('./config.js')

@server =
     port: 1337
     debug: false

@statusCode =
     success: 200
     redirect: 302
     notFound: 404
     internalError: 500

@errorHandler =
     notFound: (error, parameter) ->
          if config.server.debug then console.log(error)
          method.view(null, parameter, 'error.htm', config.statusCode.notFound)
     notFoundGeneric: (error, parameter) ->
          if config.server.debug then console.log(error)
          method.view(null, parameter, 'error.htm', config.statusCode.notFound, 'generic')
     internalError: (error, parameter) ->
          if config.server.debug then console.log(error)
          method.view(null, parameter, 'error.htm', config.statusCode.internalError)

@paths =
     content: __dirname + '/../content'
     view: __dirname + '/../view'

@localization =
     default: "en-us"
     lookup: (parameter) ->
          return config.localization.default

@mustache =
     root: config.paths.view

@mongoDb =
     enabled: false
     host: 'localhost'
     port: 27017
     db: 'blogschornio'