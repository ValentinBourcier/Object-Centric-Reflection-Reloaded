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
		'instrumentedClass'
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
RFProxyInstrumenter >> findSuperSendsChainFor: aMethod [

	| hasSuperSends nextMethod methodChain selector |
	hasSuperSends := true.
	nextMethod := aMethod.
	methodChain := OrderedCollection with: nextMethod.
	selector := aMethod selector.

	[ hasSuperSends ] whileTrue: [ 
		nextMethod := (nextMethod methodClass superclass lookupSelector: selector) 
			              ifNil: [ ^ methodChain ].
		hasSuperSends := nextMethod hasSuperSends.
		nextMethod ifNotNil: [ methodChain add: nextMethod ] ].
	^ methodChain
]

{ #category : #instrumentation }
RFProxyInstrumenter >> instrumentMethod: method selector: selector [

	| newMethod |
	
	"method hasSuperSends ifTrue:[^self instrumentMethodWithSuperSends: method]."
	
	instrumentedMessages add: selector.
	RFProxyMetaObject log: 'Instrumenting: ', selector printString.
	
	'Instrumenting ' crTrace. selector trace.
	
	instrumentedClass compile: method sourceCode.
	newMethod := instrumentedClass >> selector.
	self instrumentSelfSendsIn: newMethod ast. "instrument with what?"
	self instrumentReturnSelfIn: newMethod ast
]

{ #category : #instrumentation }
RFProxyInstrumenter >> instrumentMethodWithSuperSends: method [

	| hasSuperSends nextMethod newMethods |
	hasSuperSends := true.
	nextMethod := method.
	newMethods add: nextMethod.

	[ hasSuperSends ] whileTrue: [ 
		nextMethod := nextMethod superclass lookupSelector: method selector.
		hasSuperSends := nextMethod notNil and: [ nextMethod hasSuperSends ].
		nextMethod ifNotNil: [ newMethods add: nextMethod ] ]
]

{ #category : #instrumentation }
RFProxyInstrumenter >> instrumentReturnSelfIn: ast [

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
	self instrumentMethod: method selector: selector
]

{ #category : #instrumentation }
RFProxyInstrumenter >> instrumentSelfSendsIn: ast [
	
	(ast sendNodes select: [ :node | node receiver isSelfVariable ]) do: [ 
		:node | 
		RFProxyMetaObject log: 'overriden node receiver: ', node selector.
		node link:
			(self newLinkForSelector: node selector) ]
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

{ #category : #accessing }
RFProxyInstrumenter >> metaObject: anObject [

	metaObject := anObject
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
	^ link
]
