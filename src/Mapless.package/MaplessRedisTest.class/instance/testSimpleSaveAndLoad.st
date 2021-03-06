testing
testSimpleSaveAndLoad
	| guy loaded |
	
	guy := MaplessRedisDummyPerson new
			firstName: 'john';
			lastName: 'q';
			yourself.
	
	self assert: guy isUnsaved.	
	self do:[guy save].
	self deny: guy isUnsaved.

	self do:[ loaded := MaplessRedisDummyPerson findAt: guy oid ].
	self assert: loaded notNil.
	self deny: loaded isUnsaved.
	loaded data keysAndValuesDo: [:k :v|
		((loaded data at: k) isKindOf: DateAndTime) not ifTrue:[
			self assert: (loaded data at: k) = (guy data at: k)]].
	