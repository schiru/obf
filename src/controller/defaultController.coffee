fs        = require('fs')
mime      = require('mime')

method    = require('../core/methods.js')
config    = require('../core/config.js')


@defaultMethod = (parameter) ->
     config.errorHandler.notFound(null, parameter)

@content = (parameter) ->
     filePath = config.paths.content + parameter.request.url.replace(new RegExp(parameter.matchedRoute), '')

     if fs.existsSync(filePath) and fs.statSync(filePath).isFile()
          mimeType = mime.lookup(filePath)
          stream = fs.createReadStream(filePath)
          method.content(stream, mimeType, parameter)
     else
          config.errorHandler.notFound(null, parameter)
       