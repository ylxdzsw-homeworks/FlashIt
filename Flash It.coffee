@flashit = () ->
	#status variables
	Stack = []
	end = no

	#operation functions
	init = (code,library) ->
		end = no
		Stack = []
		stack_push code, library, -> end = yes

	next = (callback) ->
		mission = Stack.pop()
		console.log code_parse(mission.closure.code)
		
		

	#tool functions
	stack_push = (code,env,callback) ->
		Stack.push {
			closure: {
				code: code,
				env: env
			},
			callback: callback
		}

	code_parse = (code) ->
		parenthesis = counter()
		finalAns = []
		codetxt = ""
		codeToBeParse = code.trim().split('')
		if codeToBeParse.shift() isnt '('
			throw new Error("Not a valid expression that start with '('")
		for i in codeToBeParse
			if i is '('
				codetxt += i
				parenthesis.inc()
				continue
			if parenthesis.get() > 0
				codetxt += i
				if i is ')'
					if parenthesis.get() is 1
						finalAns.push codetxt
						codetxt = ""
					parenthesis.dec()
				continue
			if i in [' ','\n','\t']
				if codetxt isnt ""
					finalAns.push codetxt
					codetxt = ""
				continue
			if i isnt ')'
				codetxt += i
			else
				finalAns.push codetxt if codetxt isnt ""
		if parenthesis.get() isnt 0
			throw new Error("parenthesis not matched!\nError code:" + code.trim())
		return finalAns

	counter = (x) ->
		counts = x ? 0
		{
			inc : () ->
				counts += 1
			dec : () ->
				if counts <= 0
					throw new Error("decreased a counter less than zero")
				counts -= 1
			reset : () ->
				counts = 0
			get : () ->
				counts
		}

	#returns
	{
		init: init,
		next: next
	}

