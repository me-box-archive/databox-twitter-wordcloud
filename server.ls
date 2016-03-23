require! { express, 'body-parser', request }

app = express!

app.enable 'trust proxy'

app.use express.static 'static'

#app.use body-parser.urlencoded extended: false

app.get '/twitter/api/*' (req, res) !-> request "http://#{(process.env.BROKER_PORT_7999_TCP_ADDR or \localhost)}:7999/twitter/api/#{req.params[0]}" .pipe res

app.listen (process.env.PORT or 8080)