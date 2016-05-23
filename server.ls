require! { express, 'body-parser', request }

app = express!

app.enable 'trust proxy'

app.use express.static 'static'

app.use body-parser.urlencoded extended: false

app.get \/status (req, res) !->
  res.header 'Access-Control-Allow-Origin' \*
  res.send \active

token = null
app.get \/token (req, res) !->
  res.header 'Access-Control-Allow-Origin' \*
  token := req.query.token
  res.end!

app.get '/api/*' (req, res) !->
  request.post "http://arbiter:7999/databox-twitter-driver#{req.url}" .form { token } .pipe res

app.listen (process.env.PORT or 8080)
