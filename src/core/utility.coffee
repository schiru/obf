@createUUID = () ->
     uuidSize = 16 #Byte
     buffer = new Buffer(uuidSize)
     bufferPosition = 0

     while bufferPosition < uuidSize
          randomByte = Math.floor(Math.random() * 0xFF)
          buffer[bufferPosition] = randomByte
          bufferPosition += 1 #Byte

     return buffer.toString('hex')

@setCookie = (cookie, parameter) ->
     cookieString = ''
     for key, value of cookie
          cookieString += key
          if key != value
               cookieString += '=' + value
          cookieString += ';'

     parameter.response.setHeader('Set-Cookie', cookieString)

@parseCookieString = (cookieString) ->
     if cookieString
          cookies = {}
          cookieString.split(';').forEach((cookie) ->
               parts = cookie.split('=')
               cookies[parts[0].trim()] = parts[1].trim() || ''
          )
          return cookies
