"
I instrument the methods of a proxified object with metalinks.
My metalinks will redirect all self references (in parameters, message sends receivers, return nodes) to my meta-object who will perform a (set of) reflective action(s).

Currently, I am not in a final shape, for instance:
- my instrumentation API my change
- my instrumentation implementation may change
- I should be composeable depending on the object-centric instrumentation that is required (_e.g._, if two object-centric operations of different nature are demanded) 
"
Class {
	#name : #RFProxyInstrumenter,
	#superclass : #Object,
	#instVars : [
		'metaObject',
		'instrumentedMessages',
		'instrumentedObject',
		'instrumentedClass',
		'compiledSelectorsMap'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #'instance creation' }
RFProxyInstrumenter class >> for: aRFProxyMetaObject [

	^ self new
		  metaObject: aRFProxyMetaObject;
		  yourself
]

{ #category : #instrumentation }
RFProxyInstrumenter >> beForObject: anObject [

	anObject class isAnonymous ifFalse: [ 
		anObject class newAnonymousSubclass adoptInstance: anObject ].
	instrumentedObject := anObject.
	instrumentedClass := anObject class
]

{ #category : #instrumentation }
RFProxyInstrumenter >> buildSuperSendsChainFrom: method upTo: targetMethod in: methodChain [
	
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
RFProxyInstrumenter >> compileSuperSendChain: methodsToInstrument [

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
RFProxyInstrumenter >> compiledSelectorsMap [

	^ compiledSelectorsMap ifNil:[compiledSelectorsMap := Dictionary new]
]

{ #category : #instrumentation }
RFProxyInstrumenter >> findSuperSendsChainFor: aMethod [

	| selector nextMethod  methodChain |
	(self isClassReachableInHierarchy: aMethod methodClass) 
		ifFalse:[^OrderedCollection new.].
	
	methodChain := OrderedCollection new.
	selector := aMethod selector.			
	nextMethod := self originalClass lookupSelector: selector.	
	
	nextMethod := self buildSuperSendsChainFrom: nextMethod upTo: aMethod in: methodChain.
	nextMethod == aMethod ifFalse: [ ^ OrderedCollection new ].
	nextMethod hasSuperSends 
		ifFalse:[methodChain add: nextMethod. 
			^methodChain].

	nextMethod := self buildSuperSendsChainFrom: nextMethod upTo: nil in: methodChain.
	nextMethod ifNotNil:[methodChain add: nextMethod].
	^ methodChain
]

{ #category : #instrumentation }
RFProxyInstrumenter >> instrumentMethod: method selector: selector [

	| newMethod methodsToInstrument compiledSelectors |
	methodsToInstrument := self findSuperSendsChainFor: method.
	self flag:
		'Odd: can it really be empty? what about the method passed as paramter?'.
	methodsToInstrument isEmpty ifTrue: [ ^ self ].

	instrumentedMessages add: selector.
	compiledSelectors := self compileSuperSendChain: methodsToInstrument.

	compiledSelectors do: [ :cs | 
		| ast |
		RFProxyMetaObject log: 'Instrumenting: ' , cs printString.

		newMethod := instrumentedClass >> cs.
		ast := newMethod ast.
		"self halt."
		"self redirectSelfArgsIn: ast."
		self redirectSelfReturnsIn: ast.
		self redirectVariableAccessesIn: ast.
		self redirectMessagesSendIn: ast.
		self compiledSelectorsMap
			at: cs
			ifPresent: [ :redirectionSelector | 
				self redirectSuperSendsIn: ast toSelector: redirectionSelector ] ]
]

{ #category : #instrumentation }
RFProxyInstrumenter >> instrumentSelector: selector withArgs: args [

	| method |
	(self instrumentedMessages includes: selector) ifTrue: [ 
		RFProxyMetaObject log:
			'selector already instrumented: ' , selector printString.
		self flag:
			'Later we should compose instrumentation: inst var accesses, object-interaction, etc.'.
		^ self ].
	method := instrumentedClass lookupSelector: selector.
	method isPrimitive ifTrue: [ 
		method primitive = 188 ifTrue: [ 			
			method := args second.
			RFProxyMetaObject log: 'Primitive ' , method printString.
			self instrumentMethod: method selector: method selector.
			args removeLast.
			args addLast: (instrumentedClass lookupSelector: method selector)  ].
		^ self ].
	self instrumentMethod: method selector: selector.
	
]

{ #category : #accessing }
RFProxyInstrumenter >> instrumentedClass [

	^ instrumentedClass
]

{ #category : #accessing }
RFProxyInstrumenter >> instrumentedMessages [
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
RFProxyInstrumenter >> instrumentedObject [

	^ instrumentedObject
]

{ #category : #testing }
RFProxyInstrumenter >> isClassReachableInHierarchy: aClass [

	^ self originalClass == aClass or: [ 
		  self originalClass allSuperclasses includes: aClass ]
]

{ #category : #logging }
RFProxyInstrumenter >> log: array [

	| log |
	log := WriteStream on: String new.
	array do: [ :s | log << s ].

	RFProxyMetaObject log: log contents
]

{ #category : #accessing }
RFProxyInstrumenter >> metaObject: anObject [

	metaObject := anObject
]

{ #category : #links }
RFProxyInstrumenter >> newAfterLinkForAssignments [

	| link |
	link := MetaLink new.
	link control: #after.
	link metaObject: metaObject .
	link selector: #linkAfterAssignment: .
	link arguments: #( operation ).
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #links }
RFProxyInstrumenter >> newAfterLinkForMessagesSend [
	| link |
	link := MetaLink new.
	link control: #after.
	link metaObject: metaObject .
	link selector: #linkAfterMessageSend: .
	link arguments: #( operation ).
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #links }
RFProxyInstrumenter >> newBeforeLinkForAssignments [

	| link |
	link := MetaLink new.
	link control: #before.
	link metaObject: metaObject .
	link selector: #linkBeforeAssignment:.
	link arguments: #( operation ).
	link optionCompileOnLinkInstallation: true.

	^ link
]

{ #category : #links }
RFProxyInstrumenter >> newBeforeLinkForMessagesSend [

	| link  |
	link := MetaLink new.
	link control: #before.
	link metaObject: metaObject .
	link selector: #linkBeforeMessageSend:.
	link arguments: #( operation ).
	link optionCompileOnLinkInstallation: true.

	^ link
]

{ #category : #links }
RFProxyInstrumenter >> newInsteadLinkForAssignments [

	| link |
	link := MetaLink new.
	link control: #instead.
	link metaObject: metaObject.
	link selector: #linkInsteadAssignment:.
	link arguments: #( operation ).
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #links }
RFProxyInstrumenter >> newInsteadLinkForMessagesSend [

	| link |
	link := MetaLink new.
	link control: #instead.
	link metaObject: metaObject.
	link selector: #linkInsteadMessageSend:.
	link arguments: #( operation ).
	link optionCompileOnLinkInstallation: true.
	^ link
]

{ #category : #links }
RFProxyInstrumenter >> newLinkForSelector: selector [

	| link interceptor |
	link := MetaLink new.
	link control: #instead.
	
	interceptor := RFMessageInterceptor new.
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
RFProxyInstrumenter >> originalClass [
	^instrumentedClass superclass
]

{ #category : #instrumentation }
RFProxyInstrumenter >> redirectMessagesSendIn: ast [

	| messageSendNode |
	messageSendNode := ast sendNodes select: [ :node | node receiver isSelfVariable ].
	messageSendNode do: [ :node | 
			node link: self newBeforeLinkForMessagesSend.
			node link: self newInsteadLinkForMessagesSend.
			node link: self newAfterLinkForMessagesSend
			 ] 
]

{ #category : #instrumentation }
RFProxyInstrumenter >> redirectSelfArgsIn: ast [
	
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
RFProxyInstrumenter >> redirectSelfReturnsIn: ast [

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
RFProxyInstrumenter >> redirectSelfSendsIn: ast [
	
	| methodName nodes  |
	methodName := ast methodNode method name.
	nodes := ast sendNodes select: [ :node | node receiver isSelfVariable ].
	nodes do: [ :node | 
		self log: { 'overriden node receiver: '. node selector. ' in '. methodName }.
		node link: (self newLinkForSelector: node selector) ]
]

{ #category : #instrumentation }
RFProxyInstrumenter >> redirectSuperSendsIn: ast toSelector: aSelector [
	
	| methodName nodes  |
	methodName := ast methodNode method name.
	nodes := ast sendNodes select: [ :node | node receiver isSuperVariable ].
	nodes do: [ :node | 		
		node link: (self newLinkForSelector: aSelector) ]
]

{ #category : #instrumentation }
RFProxyInstrumenter >> redirectVariableAccessesIn: ast [

	| assignmentNodes |
	assignmentNodes := ast assignmentNodes.

	assignmentNodes do: [ :node | 
		node link: self newBeforeLinkForAssignments.
		node link: self newInsteadLinkForAssignments.
		node link: self newAfterLinkForAssignments ]
]
