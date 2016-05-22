require! { express, 'body-parser', request }

app = express!

app.enable 'trust proxy'

app.use express.static 'static'

#app.use body-parser.urlencoded extended: false

app.get '/twitter/api/*' (req, res) !-> request 'arbiter:7999/databox-twitter-driver/' .pipe res

app.listen (process.env.PORT or 8080)
