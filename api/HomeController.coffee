class HomeController
  index: (req, res)->
    res.json({status: "Everything's Good"})


    
module.exports = new HomeController