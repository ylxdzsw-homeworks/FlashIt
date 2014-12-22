@stdlib = (paper) ->
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
	'p':
		type: 'function'
		fun: (x) ->
			type: 'point'
			value: [x[0].value,x[1].value]
	'px':
		type: 'function'
		fun: (x) ->
			type: 'number'
			value: x[0].value[0]
	'py':
		type: 'function'
		fun: (x) ->
			type: 'number'
			value: x[0].value[1]

