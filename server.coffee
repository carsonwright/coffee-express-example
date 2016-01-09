fs = require("fs")
bodyParser = require('body-parser')
basicAuth = require('basic-auth')

process.env.NODE_ENV = process.env.NODE_ENV || "development"
require('./config/routes')
class Server
  constructor: ->
    @express = require('express')
    @app = @express((req)->

    )
    @database()
    @api()

    server = this
    @app.use(bodyParser.json({ type: 'application/json' }))

    @app.use((req, res, next)->
      res.setHeader('Content-Type', 'application/json')
      req.accepts('application/json')

      res.set('WWW-Authenticate', 'Basic realm=Authorization Required')
      unauthorized = (res)->
        res.set('WWW-Authenticate', 'Basic realm=Authorization Required')
        res.sendStatus(401)


      user = basicAuth(req)

      if !process.env.BYPASS_SECRET && user && user.name && user.pass
        server.App.authenticate(id: user.name, secret: user.pass).then((pass)->
          if pass
            next()
          else
            unauthorized(res)
        )
      else if process.env.BYPASS_SECRET
        next()
      else
        unauthorized(res)
    )

    @routes = require('./config/routes')

    this

  database: ->
    server = this
    @db = require('./config/db/connection')
    files = fs.readdirSync('./models')

    files.forEach((file)->
      className = file.replace(".coffee", "")
      server[className] = require("./models/#{file}")
      server[className].db = server.db
    )

  api: ->
    server = this
    files = fs.readdirSync('./api')
    files.forEach((file)->
      className = file.replace(".coffee", "")
      server[className] = require("./api/#{file}")
    )

  start: ->
    @routes.init.call(this)
    server = @app.listen(3000, (req, res)->
      host = server.address().address
      port = server.address().port

      console.log('Example app listening at http://%s:%s', host, port)
    )

(new Server()).start()
