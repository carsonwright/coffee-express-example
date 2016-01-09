class AppsController
  index: (req, res)->
    @App.all().then((data, err)->
      res.json(data)
    )
  create: (req, res)->
    @App.create(name: req.body.name, description: req.body.description).then((data)->
      res.json(data)
    ).catch((error)->
      console.log(error)
      console.log("Here")
    )


    
module.exports = new AppsController