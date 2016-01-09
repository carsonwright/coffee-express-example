request = require('request')

describe("Main", ()->
  it("should respond with hello world", (done)->
    request("http://localhost:3000/apps", (error, response, body)->
      expect(body).toEqual('[]')
      done()
    )
  )
)
