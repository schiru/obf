@createUUID = () ->
     uuidSize = 16 #Byte
     buffer = new Buffer(uuidSize)
     bufferPosition = 0

     while bufferPosition < uuidSize
          randomByte = Math.floor(Math.random() * 0xFF)
          buffer[bufferPosition] = randomByte
          bufferPosition += 1 #Byte

     return buffer.toString('hex')
