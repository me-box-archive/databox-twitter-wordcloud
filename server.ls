require! { express, 'body-parser', request }

const ARBITER_TOKEN = process.env.ARBITER_TOKEN
const PORT = process.env.PORT or 8080

unless ARBITER_TOKEN?
  throw new Error 'Arbiter token undefined'

macaroon <-! get-macaroon = (callback) !->
  err, res, macaroon <-! request.post do
    url: "http://arbiter:8080/macaroon"
    form:
      token: ARBITER_TOKEN
      target: \databox-twitter-driver.store
  if err? then throw err
  callback macaroon

app = express!

  ..use express.static 'static'

  ..use body-parser.urlencoded extended: false

  ..use (req, res, next) !->
    res.header 'Access-Control-Allow-Origin' \*
    next!

  ..get \/status (req, res) !-> res.send \active

  ..get \/api/* (req, res) !->
    err, response, body <-! request.post do
      url: "http://databox-twitter-driver.store:8080/api/#{req.params[0]}"
      form: { macaroon }
    # TODO: Error handling
    body
      |> res.send

  ..listen PORT
