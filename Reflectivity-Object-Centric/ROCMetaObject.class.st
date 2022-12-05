"
I intercept all message passing sent to my proxy.

If the message is received through the meessage send interceptor (ROCMessageSendInterceptor), I first propagate the self references and then I execute the reflective techniques corresponding to the message selector then I send that message to the proxy.

If the message is received through the Variable read or write interceptor (ROCVariableReadInterceptor, ROCVariableWriteInterceptor), I execute the reflective techniques corresponding to the variabe name then I send that message to the proxy.


If the message is received through the proxy (either directly or because I sent it to the proxy), Instrument the message and then I forward the message to the real object.

To instrument methods, I use an instance of ROCProxyInstrumenter.
"
Class {
	#name : #ROCMetaObject,
	#superclass : #Object,
	#instVars : [
		'proxy',
		'instrumenter',
		'metaLevel',
		'registryHandler',
		'instrumentedObjectMop'
	],
	#classInstVars : [
		'str'
	],
	#category : #'Reflectivity-Object-Centric-metaobjects'
}

{ #category : #'instance creation' }
ROCMetaObject class >> forObject: anObject proxy: aProxy [

	^ self new forObject: anObject proxy: aProxy
]

{ #category : #logging }
ROCMetaObject class >> log: info [

	| stream |
	info crTrace.
	stream := (str ifNil: [ str := 'log' asFileReference ]) writeStream.
	stream position: str size.
	stream
		nextPutAll: info;
		cr;
		close
]

{ #category : #'reflective api' }
ROCMetaObject >> executeReflectiveOperationsFor: target uponReceptionOf: selector [

	<debuggerCompleteToSender>
	(String streamContents: [ :stream | 
		 stream << 'Reflective action for:'.
		 stream space.
		 stream << target printString.
		 stream space.
		 stream << 'receiving message:'.
		 stream space.
		 stream << selector printString ]) crTrace
]

{ #category : #'reflective api' }
ROCMetaObject >> executeReflectiveOperationsForAssignment: anOperation [

	| timeObject operation |
	self metaLevel ifTrue: [ ^ anOperation value ].
	self
		verifyExistenceOn: self registryHandler variableWriteRegistry
		withKey: anOperation variable name.
	timeObject := self registryHandler variableWriteRegistry blocksStored 
		              at: anOperation variable name.
	self metaLevel: true.
	timeObject before ifNotEmpty: [ 
		timeObject before do: [ :each | each value ] ].
	operation := timeObject instead
		             ifNil: [ 
			             self metaLevel: false.
			             anOperation value ]
		             ifNotNil: [ timeObject instead value ].
	self metaLevel: true.
	timeObject after ifNotEmpty: [ 
		timeObject after do: [ :each | each value ] ].
	self metaLevel: false.
	^ operation
]

{ #category : #execution }
ROCMetaObject >> executeReflectiveOperationsForMessageSendOperation: aOperation [

	| timeObject operation |
	aOperation selector crTrace.
	self metaLevel ifTrue: [ 
		^ aOperation value ].
	self
		verifyExistenceOn: self registryHandler messageSendRegistry
		withKey: aOperation selector.
	timeObject := self registryHandler messageSendRegistry blocksStored 
		              at: aOperation selector.
	self metaLevel: true.
	timeObject before ifNotEmpty: [ 
		timeObject before do: [ :each | each value ] ].
	operation := timeObject instead
		             ifNil: [ 
			             self metaLevel: false.
			             aOperation value.
			           ]
		             ifNotNil: [ timeObject instead value ].
	  self metaLevel: true .
	timeObject after ifNotEmpty: [ 
		timeObject after do: [ :each | each value ] ].
	self metaLevel: false.
	^ operation
	"^ aOperation value."
]

{ #category : #execution }
ROCMetaObject >> executeReflectiveOperationsForVariableRead: name withValue: aValue [

	| timeObject operation |
	self metaLevel ifTrue: [ ^ aValue ].
	self
		verifyExistenceOn: self registryHandler variableReadRegistry
		withKey: name.
	timeObject := self registryHandler variableReadRegistry blocksStored 
		              at: name.
	self metaLevel: true.
	timeObject before ifNotEmpty: [ 
		timeObject before do: [ :each | each value ] ].
	operation := timeObject instead
		             ifNil: [ 
			             self metaLevel: false.
			             aValue ]
		             ifNotNil: [ timeObject instead value ].
	self metaLevel: true.
	timeObject after ifNotEmpty: [ 
		timeObject after do: [ :each | each value ] ].
	self metaLevel: false.
	^ operation
]

{ #category : #private }
ROCMetaObject >> forObject: anObject [

	self instrumenter beForObject: anObject
]

{ #category : #initialization }
ROCMetaObject >> forObject: anObject proxy: aProxy [

	self forObject: anObject.
	self proxy: aProxy
]

{ #category : #accessing }
ROCMetaObject >> instrumentedObjectMop [

	^instrumentedObjectMop
]

{ #category : #accessing }
ROCMetaObject >> instrumentedObjectMop: anObject [

	instrumentedObjectMop := anObject
]

{ #category : #accessing }
ROCMetaObject >> instrumenter [

	^ instrumenter ifNil: [ instrumenter := ROCProxyInstrumenter for: self ]
]

{ #category : #accessing }
ROCMetaObject >> instrumenter: anObject [

	instrumenter := anObject
]

{ #category : #accessing }
ROCMetaObject >> metaLevel [

	^ metaLevel ifNil: [ metaLevel := false ]
]

{ #category : #accessing }
ROCMetaObject >> metaLevel: anObject [

	^ metaLevel := anObject
]

{ #category : #accessing }
ROCMetaObject >> proxy [

	^ proxy
]

{ #category : #accessing }
ROCMetaObject >> proxy: anObject [

	proxy := anObject
]

{ #category : #'message passing' }
ROCMetaObject >> receive: aSelector [
	<debuggerCompleteToSender>
	self class log: 'receive: ' , aSelector printString.
	aSelector = #class ifTrue: [ 
		self flag: 'Temporary hack in waiting a nicer solution'.
		self flag: 'We should filter the reflective API'.
		^ instrumenter instrumentedClass superclass ].
	aSelector ifNil: [ ^ self proxy ].
	^ self
		  send: aSelector
		  withArgs: #(  )
		  to: instrumenter instrumentedObject
]

{ #category : #'message passing' }
ROCMetaObject >> receive: aSelector withArgs: args [

	self class log: 'receive w/args: ' , aSelector printString, ' args: ', args printString.
	^ self
		  send: aSelector
		  withArgs: args
		  to: instrumenter instrumentedObject
]

{ #category : #accessing }
ROCMetaObject >> receiver [

	^ instrumenter instrumentedObject
]

{ #category : #accessing }
ROCMetaObject >> registryHandler [

	^ registryHandler ifNil: [ 
		  registryHandler := ROCBlocksRegistryHandler new ]
]

{ #category : #accessing }
ROCMetaObject >> registryHandler: anObject [

	registryHandler := anObject
]

{ #category : #deprecated }
ROCMetaObject >> send: aMessage to: target [

	
	self class log: 'sendNA: ' , aMessage printString.
	aMessage arguments: aMessage arguments asOrderedCollection. 
	self instrumenter instrumentSelector: aMessage selector withArgs: aMessage arguments.
	aMessage arguments: aMessage arguments asArray.
	self executeReflectiveOperationsFor: target uponReceptionOf: aMessage.
	^ aMessage sendTo: target
]

{ #category : #'message passing' }
ROCMetaObject >> send: selector withArgs: args to: target [

	<debuggerCompleteToSender>
	| arguments |
	arguments := args asOrderedCollection.
	"self executeReflectiveOperationsFor: target uponReceptionOf: selector."
	self instrumenter instrumentSelector: selector withArgs: arguments.

	^ MirrorPrimitives
		  withReceiver: target
		  perform: selector
		  withArguments: arguments asArray
]

{ #category : #execution }
ROCMetaObject >> verifyExistenceOn: aRegistry withKey: aKey [

	[ aRegistry blocksStored at: aKey ]
		on: KeyNotFound
		do: [ 
			aRegistry blocksStored at: aKey put: ROCBlocksExecutionOrder new.
			aRegistry propagateAllBlocksStored: aKey ]
]
