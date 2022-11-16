"
I instrument the methods of a proxified object with metalinks.
My metalinks will redirect all self references (in parameters, message sends receivers, return nodes) to my meta-object who will perform a (set of) reflective action(s).

Currently, I am not in a final shape, for instance:
- my instrumentation API my change
- my instrumentation implementation may change
- I should be composeable depending on the object-centric instrumentation that is required (_e.g._, if two object-centric operations of different nature are demanded) 
"
Class {
	#name : #ROCProxyInstrumenter,
	#superclass : #Object,
	#instVars : [
		'metaObject',
		'instrumentedMessages',
		'instrumentedObject',
		'instrumentedClass',
		'compiledSelectorsMap'
	],
	#category : #'Reflectivity-Object-Centric-instrumentation'
}

{ #category : #'instance creation' }
ROCProxyInstrumenter class >> for: aRFProxyMetaObject [

	^ self new
		  metaObject: aRFProxyMetaObject;
		  yourself
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> beForObject: anObject [

	anObject class isAnonymous ifFalse: [ 
		anObject class newAnonymousSubclass adoptInstance: anObject ].
	instrumentedObject := anObject.
	instrumentedClass := anObject class
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> buildSuperSendsChainFrom: method upTo: targetMethod in: methodChain [
	
	| selector nextMethod |
	selector := method selector.
	nextMethod := method.
	[ nextMethod ~~ targetMethod and: [ nextMethod hasSuperSends ] ] 
		whileTrue: [ 
			| nextClass |
			methodChain add: nextMethod.
			nextClass := nextMethod methodClass superclass 
								ifNil: [^ nextMethod ].
			nextMethod := nextClass lookupSelector: selector ].
	^ nextMethod
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> compileSuperSendChain: methodsToInstrument [

	| newSelectors originalSelector lastSelector |
	newSelectors := OrderedCollection new.
	methodsToInstrument isEmpty ifTrue: [ ^ newSelectors ].

	instrumentedClass compile: methodsToInstrument first sourceCode.
	originalSelector := methodsToInstrument first selector.
	newSelectors add: originalSelector.
	methodsToInstrument size = 1 ifTrue: [ ^ newSelectors ].

	lastSelector := originalSelector.

	2 to: methodsToInstrument size do: [ :i | 
		| method newSourceCode newSelector |
		method := methodsToInstrument at: i.

		newSourceCode := String streamContents: [ :s | 
			                 s << '_'.
			                 s << i printString.
			                 s << '_'.
			                 s << method sourceCode ].

		newSelector := instrumentedClass compile: newSourceCode.
		newSelectors add: newSelector.
		self compiledSelectorsMap at: lastSelector put: newSelector.
		lastSelector := newSelector ].
	
^newSelectors
]

{ #category : #accessing }
ROCProxyInstrumenter >> compiledSelectorsMap [

	^ compiledSelectorsMap ifNil:[compiledSelectorsMap := Dictionary new]
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> findSuperSendsChainFor: aMethod [

	| selector nextMethod methodChain |
	(self isClassReachableInHierarchy: aMethod methodClass) ifFalse: [ 
		^ OrderedCollection new ].

	methodChain := OrderedCollection new.
	selector := aMethod selector.
	nextMethod := self originalClass lookupSelector: selector.

	nextMethod := self
		              buildSuperSendsChainFrom: nextMethod
		              upTo: aMethod
		              in: methodChain.
	nextMethod == aMethod ifFalse: [ ^ OrderedCollection new ].
	nextMethod hasSuperSends ifFalse: [ 
		methodChain add: nextMethod.
		^ methodChain ].

	nextMethod := self
		              buildSuperSendsChainFrom: nextMethod
		              upTo: nil
		              in: methodChain.
	nextMethod ifNotNil: [ methodChain add: nextMethod ].
	^ methodChain
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> instrumentMethod: method selector: selector [

	| newMethod methodsToInstrument compiledSelectors |
	methodsToInstrument := self findSuperSendsChainFor: method.
	self flag:
		'Odd: can it really be empty? what about the method passed as paramter?'.
	methodsToInstrument isEmpty ifTrue: [ ^ self ].

	instrumentedMessages add: selector.
	compiledSelectors := self compileSuperSendChain: methodsToInstrument.

	compiledSelectors do: [ :cs | 
		| ast |
		ROCMetaObject log: 'Instrumenting: ' , cs printString.
		newMethod := instrumentedClass >> cs.
		ast := newMethod ast.
		"self redirectSelfArgsIn: ast."  "link for selector instead with Nil"
		self redirectMessagesSendIn: ast.
		self redirectSelfReturnsIn: ast. "link for selector after with Nil"
		self redirectVariableReadingIn: ast.
		self redirectVariableWritingIn: ast.

		self compiledSelectorsMap
			at: cs
			ifPresent: [ :redirectionSelector | 
				self redirectSuperSendsIn: ast toSelector: redirectionSelector "link for selector" ] ]
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> instrumentSelector: selector withArgs: args [

	| method |
	(self instrumentedMessages includes: selector) ifTrue: [ 
		ROCMetaObject log:
			'selector already instrumented: ' , selector printString.
		self flag:
			'Later we should compose instrumentation: inst var accesses, object-interaction, etc.'.
		^ self ].
	method := instrumentedClass lookupSelector: selector.
	method isPrimitive ifTrue: [ 
		method primitive = 188 ifTrue: [ 			
			method := args second.
			ROCMetaObject log: 'Primitive ' , method printString.
			self halt.
			self instrumentMethod: method selector: method selector.
			args removeLast.
			args addLast: (instrumentedClass lookupSelector: method selector)  ].
		^ self ].
	self instrumentMethod: method selector: selector.
	
]

{ #category : #accessing }
ROCProxyInstrumenter >> instrumentedClass [

	^ instrumentedClass
]

{ #category : #accessing }
ROCProxyInstrumenter >> instrumentedMessages [
	self flag: 'Temporary hack in waiting a nicer solution'.
	^ instrumentedMessages ifNil: [ 
		  instrumentedMessages := OrderedCollection new
			                          "add: #isSymbol;
			                          add: #perform:;
			                          add: #perform:withArguments:;"
			                          add: #class;
			                          yourself ]
]

{ #category : #accessing }
ROCProxyInstrumenter >> instrumentedObject [

	^ instrumentedObject
]

{ #category : #testing }
ROCProxyInstrumenter >> isClassReachableInHierarchy: aClass [

	^ self originalClass == aClass or: [ 
		  self originalClass allSuperclasses includes: aClass ]
]

{ #category : #logging }
ROCProxyInstrumenter >> log: array [

	| log |
	log := WriteStream on: String new.
	array do: [ :s | log << s ].

	ROCMetaObject log: log contents
]

{ #category : #accessing }
ROCProxyInstrumenter >> metaObject [
	^ metaObject
]

{ #category : #accessing }
ROCProxyInstrumenter >> metaObject: anObject [

	metaObject := anObject
]

{ #category : #links }
ROCProxyInstrumenter >> newInsteadLinkForAssignments [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.

	interceptor := ROCVariableWriteInterceptor new.
	interceptor metaObject: metaObject.

	link metaObject: interceptor.
	link selector: #execute:.
	link arguments: #( operation ).
	"link selector: #execute:withValue:.
	link arguments: #( name value )."
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #links }
ROCProxyInstrumenter >> newInsteadLinkForMessagesSend [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.

	interceptor := ROCMessageSendInterceptor new.
	interceptor metaObject: metaObject.

	link metaObject: interceptor.
	link selector: #execute:.
	link arguments: #( operation ).
	"link arguments: #( selector receiver arguments value ).
	link optionArgsAsArray: true."
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #links }
ROCProxyInstrumenter >> newInsteadLinkForVariableRead [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.

	interceptor := ROCVariableReadInterceptor new.
	interceptor metaObject: metaObject.

	link metaObject: interceptor.
	"link selector: #execute:.
	link arguments: #( operation )."
	link selector: #execute:withValue:.
	link arguments: #( name value).
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #links }
ROCProxyInstrumenter >> newLinkForSelector: selector [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.
	
	interceptor := ROCMessageInterceptor new.
	interceptor selector: selector.
	interceptor metaObject: metaObject.
	
	link metaObject: interceptor.
	(selector notNil and: [selector isKeyword])
		ifTrue: [ 
			link selector: #executeWithArgs:.
			link arguments: #( arguments )]
		ifFalse: [ link selector: #execute ].

	link optionCompileOnLinkInstallation: true.
"	link level: 0."
	^ link
]

{ #category : #accessing }
ROCProxyInstrumenter >> originalClass [
	^instrumentedClass superclass
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> redirectMessagesSendIn: ast [

	| messageSendNode |
	messageSendNode := ast sendNodes reject: [ :node | node isBinary ].
	messageSendNode do: [ :node | 
		node link: (self newInsteadLinkForMessagesSend) ]
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> redirectSelfArgsIn: ast [
	
	| methodName nodes  |
	methodName := ast methodNode method name .
	nodes := ast sendNodes select: [ :node | node arguments notEmpty ].
	nodes do: 
		[ :sendNode | 
			(sendNode arguments select: [ :node | node isSelfVariable ]) 
				do: [ :node |
					self log: { 'overriden self argument: '. node selector. ' in '. methodName}.
					node link: ((self newLinkForSelector: nil) control: #instead; yourself) ] ]
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> redirectSelfReturnsIn: ast [

	| returnNodes |
	returnNodes := ast allChildren select: [ :node | 
		               node isReturn and: [ node value isSelfVariable ] ].
	returnNodes do: [ :node | 
	
		node value link:
			((self newLinkForSelector: nil)
				 control: #after;
				 yourself) ]
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> redirectSelfSendsIn: ast [
	
	| methodName nodes  |
	methodName := ast methodNode method name.
	nodes := ast sendNodes select: [ :node | node receiver isSelfVariable ].
	nodes do: [ :node | 
		self log: { 'overriden node receiver: '. node selector. ' in '. methodName }.
		node link: (self newLinkForSelector: node selector) ]
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> redirectSuperSendsIn: ast toSelector: aSelector [
	
	| methodName nodes  |
	methodName := ast methodNode method name.
	nodes := ast sendNodes select: [ :node | node receiver isSuperVariable ].
	nodes do: [ :node | 		
		node link: (self newLinkForSelector: aSelector) ]
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> redirectVariableReadingIn: ast [

	| variableReadNodes |
	variableReadNodes := ast variableReadNodes.
	variableReadNodes := variableReadNodes reject: [ :node | 
		                     node isSelfVariable or: [ 
			                     node isSuperVariable or: [ 
				                     node isThisContextVariable or: [ 
					                     ast hasArgumentNamed: node name ] ] ] ].
	variableReadNodes do: [ :node | 
		node link: self newInsteadLinkForVariableRead ]
]

{ #category : #instrumentation }
ROCProxyInstrumenter >> redirectVariableWritingIn: ast [

	| assignmentNodes |
	assignmentNodes := ast assignmentNodes.
	assignmentNodes do: [ :node | 
		node link: self newInsteadLinkForAssignments ]
]
