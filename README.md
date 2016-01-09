# coffee-express-example
###Database Setup
#### Config
Fill out the information in the config/db/database.json file
#### Migrations
To run migrations use the following
```bash
db-migrate up
```

To reverse a migration 
```bash
db-migrate down
```

### Routes
Use the config/routes.coffee file to set your routes. Standard express methods can be used here off of @app
```coffeescript
@app.get("/", (req, res)-> res.send("Hello World"))
```

Or to use a controller action (this will trigger the HomeController's index method)
```coffeescript
@app.get("/", @HomeController.index.bind(this))
```

### Api
  Use the api/YourControllerNameController.coffee naming convention to create your api controllers (Controllers)
##### NOTE: Make sure you name your controllers with the correct capitalization, because that name is what the application uses for the attachement to the server instance


```coffeescript
class YourControllerNameController
  yourAction: (req, res)->
      
module.exports = new YourControllerName
```

### Models
  Use the models/YourModelName.coffee naming convention to create yoru models
```coffeescript
class YourModelName
  where: (params)->
    @db.query("select * from your_model_name where id=${id}, name=${name}", params)
```


    
