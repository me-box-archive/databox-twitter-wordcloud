require! { express, 'body-parser' }

app = express!

app.enable 'trust proxy'

app.use express.static 'static'

app.use body-parser.urlencoded extended: false

app.post '/list-apps' (req, res) !->
  err, containers <-! docker.list-containers all: req.body.all
  containers |> JSON.stringify |> res.end

app.post '/list-store' (req, res) !->
  res.end '{}'

app.post '/400' (req, res) !->
  res.write-head 400
  res.end!

app.listen (process.env.PORT or 8080)
