$ ->
	socket = io.connect 'http://localhost'

	roomarray = window.location.pathname.split '/'
	room = roomarray[1]
	console.log 'room: ' + room
	socket.emit 'switch', room

	socket.on 'messages', (data) ->
		if(data.room == room)
			$('#results').append('<div>' + data.time + ' || ' + data.room + ' || ' + data.name + ': ' + data.message + '</div>')

	$('#chatter').on 'submit', (e) ->
		e.preventDefault & e.preventDefault()
		message = $('#message').val()
		time = moment(new Date())
		time = time.format('HH:mm:ss')
		socket.emit 'send', {'message': message, 'name': name, 'time': time, 'room': room}
		$('<div/>', {text: time + ' || ' + room + ' || ' + name + ': ' + message}).appendTo('#results')
		$('#message').val ''