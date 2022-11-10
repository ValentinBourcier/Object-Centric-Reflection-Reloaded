"
I intercept all message passing sent to my proxy.

If the message is received through an interceptor (RFMessageInterceptor), I first instrument the code of the method corresponding to the message selector, then I send that message to the proxy.

If the message is received through the proxy (either directly or because I sent it to the proxy), I first execute reflective actions then I forward the message to the real object.

To instrument methods, I use an instance of RFProxyInstrumenter.
"
Class {
	#name : #ROCMetaObject,
	#superclass : #Object,
	#instVars : [
		'proxy',
		'instrumenter',
		'metaLevel',
		'registryHandler'
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
ROCMetaObject >> instrumenter [

	^ instrumenter ifNil: [ instrumenter := ROCProxyInstrumenter for: self ]
]

{ #category : #accessing }
ROCMetaObject >> instrumenter: anObject [

	instrumenter := anObject
]

{ #category : #execution }
ROCMetaObject >> linkInsteadAssignment: operation [

	| timeObject insteadBlock |
	self metaLevel ifTrue: [ ^ operation value ].
	[ self registryHandler variableWriteRegistry blocksStored at: operation variable name ]
		on: KeyNotFound
		do: [ 
			self registryHandler variableWriteRegistry blocksStored
				at: operation variable name
				put: ROCBlocksExecutionOrder new.
			self registryHandler variableWriteRegistry propagateAllBlocksStored: operation variable name ].
	timeObject := self registryHandler variableWriteRegistry blocksStored at:
		              operation variable name.
	self metaLevel: true.
	timeObject before ifNotEmpty: [ 
		timeObject before do: [ :each | each value ] ].
	timeObject instead
		ifNil: [ insteadBlock := operation value ]
		ifNotNil: [ insteadBlock := timeObject instead value ].
	timeObject after ifNotEmpty: [ 
		timeObject after do: [ :each | each value ] ].
	self metaLevel: false.
	^ insteadBlock
]

{ #category : #execution }
ROCMetaObject >> linkInsteadAssignment: aName withValue: aValue [

	| timeObject insteadBlock |
	self metaLevel ifTrue: [ ^ aValue ].
	[ self assignmentsStoring blocksStored at: aName ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring blocksStored
				at: aName
				put: ROCBlocksExecutionOrder new.
			self assignmentsStoring propagateAllBlocksStored: aName ].
	timeObject := self assignmentsStoring blocksStored at: aName.
	self metaLevel: true.
	timeObject after ifNotEmpty: [ 
		timeObject after do: [ :each | each value ] ].
	insteadBlock := aValue.
	timeObject instead ifNotNil: [ 
		insteadBlock := timeObject instead value ].
	timeObject before ifNotEmpty: [ 
		timeObject before do: [ :each | each value ] ].
	self metaLevel: false.
	^ insteadBlock
]

{ #category : #execution }
ROCMetaObject >> linkInsteadMessageSend: anArrayOfArguments [

	| timeObject insteadBlock aSelector aValue|
	aSelector := anArrayOfArguments first. 
	aValue := anArrayOfArguments last. 
	self metaLevel ifTrue: [ ^ aValue ].
	[ self messageSendStoring blocksStored at: aSelector ]
		on: KeyNotFound
		do: [ 
			self messageSendStoring blocksStored
				at: aSelector
				put: ROCBlocksExecutionOrder new.
			self messageSendStoring propagateAllBlocksStored: aSelector].
	timeObject := self messageSendStoring blocksStored at: aSelector.
	self metaLevel: true.
	timeObject before ifNotEmpty: [ 
		timeObject before do: [ :each | each value ] ].
	timeObject instead
		ifNil: [ insteadBlock :=  aValue ]
		ifNotNil: [ insteadBlock :=  timeObject instead value ].
	timeObject after ifNotEmpty: [ 
		timeObject after do: [ :each | each value ] ].
	self metaLevel: false.
	^  aValue
]

{ #category : #execution }
ROCMetaObject >> linkInsteadMessageSendOperation: aOperation [

	| timeObject insteadBlock |
	self metaLevel ifTrue: [ ^  aOperation value ].
	[ self registryHandler messageSendRegistry  blocksStored at:  aOperation selector ]
		on: KeyNotFound
		do: [ 
			self registryHandler messageSendRegistry blocksStored
				at: aOperation selector
				put: ROCBlocksExecutionOrder new.
			self registryHandler messageSendRegistry propagateAllBlocksStored: aOperation selector ].
	timeObject := self registryHandler messageSendRegistry blocksStored at: aOperation selector.
	self metaLevel: true.
	timeObject before ifNotEmpty: [ 
		timeObject before do: [ :each | each value ] ].
	timeObject instead
		ifNil: [ insteadBlock :=  aOperation value  ]
		ifNotNil: [ insteadBlock :=  timeObject instead value ].
	timeObject after ifNotEmpty: [ 
		timeObject after do: [ :each | each value ] ].
	self metaLevel: false.
	^  aOperation value
]

{ #category : #execution }
ROCMetaObject >> linkInsteadVariableRead: name withValue: aValue [

	| timeObject insteadBlock |
	self metaLevel ifTrue: [ ^ aValue ].
	[ self registryHandler variableReadRegistry blocksStored at: name ]
		on: KeyNotFound
		do: [ 
			self registryHandler variableReadRegistry blocksStored
				at: name
				put: ROCBlocksExecutionOrder new.
			self registryHandler variableReadRegistry 
				propagateAllBlocksStored: name ].
	timeObject := self registryHandler variableReadRegistry blocksStored 
		              at: name.
	self metaLevel: true.
	timeObject after ifNotEmpty: [ 
		timeObject after do: [ :each | each value ] ].
	timeObject instead
		ifNil: [ insteadBlock := aValue ]
		ifNotNil: [ timeObject instead value ].
	timeObject before ifNotEmpty: [ 
		timeObject before do: [ :each | each value ] ].
	self metaLevel: false.
	^ aValue


	"	self class log:
		'METAOBJECT INSTEAD VARIABLE READ  :  ' , name asString
		, '   withValue:  ' , aValue printString."
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
