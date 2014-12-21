@flashit = () ->
	#status variables
	Stack = []
	end = no

	#operation functions
	init = (code,library) ->
		end = no
		Stack = []
		push_stack code, library, -> end = yes

	next = (callback) ->
		mission = Stack.pop()
		if is_atom mission.closure.code
			obj = translate_atom mission.closure.code, mission.closure.env
			callback(obj)

		else
			console.log 'no'
		#console.log parse_code(mission.closure.code)
		
		

	#tool functions
	push_stack = (code,env,callback) ->
		Stack.push {
			closure: {
				type: 'closure'
				code: code,
				env: env
			},
			callback: callback
		}

	parse_code = (code) ->
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

	translate_atom = (code,env) ->
		codeToBeTranslate = code.trim()
		if codeToBeTranslate is '#f'
			return {type:'bool',value:false}
		if not isNaN Number(codeToBeTranslate)
			return {type:'number',value:Number codeToBeTranslate}
		if env[codeToBeTranslate]?
			return env[codeToBeTranslate]
		{type:'undefined'}

	is_atom = (code) ->
		x = code.trim().split('')
		' ' not in x and '(' not in x

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

