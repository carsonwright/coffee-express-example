uuid = require('node-uuid')
crypto = require('crypto')

class App
	@all = ->
		@db.query("select * from apps")
	@create = (params)->
		params.id = uuid.v4()
		params.secret = crypto.randomBytes(64).toString('hex')
		params.created_at = new Date()

		db = @db
		new Promise((resolve, reject)->
			db.none("INSERT INTO apps (id, secret, name, description, created_at) VALUES (${id}, ${secret}, ${name}, ${description}, ${created_at})", params).then(->
				db.one("SELECT * FROM apps ORDER BY created_at DESC LIMIT 1").then((data)->
					resolve(data)
				)
			).catch((error)->
				reject(error)
				console.log(error)
			)
		)
	@authenticate = (params)->
		@db.query("SELECT id, secret FROM apps WHERE apps.id = '${id}' AND apps.secret = '${secret}' LIMIT 1", params)

module.exports = App
