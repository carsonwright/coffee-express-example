fs = require("fs")
pgp = require('pg-promise')()

config = JSON.parse(fs.readFileSync("./config/db/database.json"))[process.env.NODE_ENV]

for key in Object.keys(config)
  if config[key].ENV?
    config[key] = process.env[config[key].ENV]
console.log(config)
module.exports = pgp(config)