class Routes
  init: ()->
    @app.get("/", @HomeController.index.bind(this))
    @app.get("/apps", @AppsController.index.bind(this))
    @app.post("/apps", @AppsController.create.bind(this))

module.exports = new Routes