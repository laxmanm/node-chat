exp = require 'express'
app = exp()
http = require 'http'
io = require('socket.io').listen app.listen 1337
hb = require 'express3-handlebars'

app.configure ->
	app.set 'views', __dirname + '/views'
	app.engine 'handlebars', hb({defaultLayout: false})
	app.set 'view engine', 'handlebars'
	app.use exp.static __dirname + '/public'

# Controller

app.get '/:id/:name', (req, res) ->
	res.render 'index', {title: 'Chat', name: req.params.name}

io.sockets.on 'connection', (socket) ->
	socket.on 'send', (data) ->
		socket.broadcast.emit 'messages', data
	socket.on 'switch', (room) ->
		socket.join room

console.log 'Server running at http://localhost:1337'