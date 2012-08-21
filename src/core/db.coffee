mongodb = require('mongodb')

config = require('./config.js')

dbServer = new mongodb.Server(config.mongoDb.host, config.mongoDb.port, { auto_reconnect: true })
@instance = new mongodb.Db(config.mongoDb.dbName, dbServer)

@instance.open((error) ->
     if error
          console.log('FATAL ERROR: Cannot connect to DB')
          process.exit(1)
)