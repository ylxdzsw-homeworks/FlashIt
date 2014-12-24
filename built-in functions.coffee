@stdlib = (canvas,size,onframe) ->
	#settings
	onframe ?= -> console.log("one frame goes by")

	rx = (x)-> x * size.width / 100
	ry = (y)-> y * size.height / 100
	ux = (x)-> x / size.width * 100
	uy = (y)-> y / size.height * 100
	
	storyboard = []

	#base functions
	'print':
		type: 'function'
		fun: (x) ->
			console.log x
	'list':
		type: 'function'
		fun: (x) ->
			type: 'list'
			value: x
	'is_list':
		type: 'function'
		fun: (x) ->
			type: 'bool'
			value: x[0].type is 'list'
	'car':
		type: 'function'
		fun: (x) ->
			x[0].value[0]
	'cdr':
		type: 'function'
		fun: (x) ->
			type: 'list'
			value: x[0].value[1..]
	'cadr':
		type: 'function'
		fun: (x) ->
			x[0].value[1]
	'=':
		type: 'function'
		fun: (x) ->
			if x[0].type is x[1].type and x[0].value is x[1].value
				type: 'bool'
				value: true
			else
				type: 'bool'
				value: false
	'++':
		type: 'function'
		fun: (x) ->
			L = []
			x.map (x) ->
				if x.type is 'list'
					L = L.concat x.value
				else
					L.push x
			type: 'list'
			value: L


	#math functions
	'+':
		type: 'function'
		fun: (x) ->
			type: 'number'
			value: x.map (x)->x.value
				.reduce (a,b)->a+b
	'-':
		type: 'function'
		fun: (x) ->
			type: 'number'
			value: x[0].value - x[1].value
	'*':
		type: 'function'
		fun: (x) ->
			type: 'number'
			value: x.map (x)->x.value
				.reduce (a,b)->a*b
	'/':
		type: 'function'
		fun: (x) ->
			type: 'number'
			value: x[0].value / x[1].value
	'mod':
		type: 'function'
		fun: (x) ->
			type: 'number'
			value: x[0].value % x[1].value
	'^':
		type: 'function'
		fun: (x) ->
			type: 'number'
			value: Math.pow(x[0].value,x[1].value)
	'PI':
		type: 'number'
		value: Math.PI
	'E':
		type: 'number'
		value: Math.E
	'sqrt':
		type: 'function'
		fun: (x)->
			type: 'number'
			value: Math.sqrt x[0].value
	#graph functions
	'g':
		type: 'function'
		fun: (x) ->
			type: 'graph'
			value: x.map (x) -> x.value
				.reduce (x,y) -> x.concat(y)

	'p':
		type: 'function'
		fun: (x) ->
			type: 'point'
			value: 
				x: x[0].value
				y: x[1].value
	'px':
		type: 'function'
		fun: (x) ->
			type: 'number'
			value: x[0].value.x
	'py':
		type: 'function'
		fun: (x) ->
			type: 'number'
			value: x[0].value.y
	'line':
		type: 'function'
		fun: (x) ->
			type: 'graph'
			value: [
				pos: []
				draw: ->
					if @pos.length
						canvas.beginPath()
						canvas.moveTo rx(@pos[0]+x[0].value.x),ry(@pos[1]+x[0].value.y)
						canvas.lineTo rx(@pos[0]+x[1].value.x),ry(@pos[1]+x[1].value.y)
						canvas.closePath()
						canvas.stroke()
			]
	'place':
		type: 'function'
		fun: (x) ->
			x[0].value.map (f) ->
				f.pos = [x[1].value.x,x[1].value.y]
				storyboard.push f
			type: 'undefined'
	'shift':
		type: 'function'
		fun: (x) ->
			x[0].value.map (f) ->
				f.pos[0] += x[1].value.x
				f.pos[1] += x[1].value.y				
			type: 'undefined'
	'draw':
		type: 'function'
		fun: (x) ->
			canvas.clearRect 0,0,size.width,size.height
			storyboard.map (x) ->
				x.draw()
			onframe() if onframe?
			type: 'undefined'








	



