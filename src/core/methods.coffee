mustache       = require('mu2')
querystring    = require('querystring')

config         = require('./config.js')


@view = (model, parameter, viewPath, statusCode = config.statusCode.success) ->
     parameter.response.writeHead(statusCode, 'Content-Type': 'text/html')
     fileStream = mustache.compileAndRender(viewPath, model)
     fileStream.pipe(parameter.response)

@redirect = (path, parameter) ->
     parameter.response.writeHead(config.statusCode.redirect, 'Location': path)
     parameter.response.end()

@content = (fileStream, contentType, parameter) ->
     parameter.response.writeHead(config.statusCode.success, 'Content-Type': contentType)
     fileStream.pipe(parameter.response)

@json = (model, parameter) ->
     parameter.response.writeHead(config.statusCode.success, 'Content-Type': 'application/json')
     parameter.response.write(JSON.stringify(model))
     parameter.response.end()

@getPostData = (parameter, callback) ->
     fullData = ''
     parameter.request.on('data', (data) ->
          fullData += data
     )
     parameter.request.on('end', () ->
          postData = querystring.parse(fullData)

          callback(postData)
     )