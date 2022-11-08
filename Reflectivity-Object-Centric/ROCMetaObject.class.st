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
		'assignmentsStoring',
		'variableReadStoring',
		'messageSendStoring'
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

{ #category : #'declaration accessing' }
ROCMetaObject >> afterAnyAssignmentDo: aBlock [

	self assignmentsStoring blocksStored valuesDo: [ :eachValue | 
		eachValue addAfter: aBlock ].
	self assignmentsStoring addAllBlocksAfter: aBlock.
]

{ #category : #'declaration accessing' }
ROCMetaObject >> afterAnyMessageSendDo: aBlock [

	self messageSendStoring blocksStored valuesDo: [ :eachValue | 
		eachValue addAfter: aBlock ].
	self messageSendStoring addAllBlocksAfter: aBlock.
]

{ #category : #'declaration accessing' }
ROCMetaObject >> afterAnyVariableReadDo: aBlock [

	self variableReadStoring blocksStored valuesDo: [ :eachValue | 
		eachValue addAfter: aBlock ].
	self variableReadStoring addAllBlocksAfter: aBlock.
]

{ #category : #'declaration accessing' }
ROCMetaObject >> afterAssignmentTo: aVariable do: aBlock [

	| variableToStore |
	(self assignmentsStoring blocksStored includesKey: aVariable) 
		ifTrue: [ 
			| aTimeObject |
			aTimeObject := self assignmentsStoring blocksStored at: aVariable.
			aTimeObject addAfter: aBlock.
			^ aTimeObject ].
	self assignmentsStoring blocksStored
		at: aVariable
		put: ROCBlocksExecutionOrder new.
	variableToStore := self assignmentsStoring blocksStored at: aVariable.
	assignmentsStoring allBlocksBefore do: [ :each | 
		variableToStore addBefore: each ].
	assignmentsStoring allBlocksAfter do: [ :each | 
		variableToStore addAfter: each ].
	[ assignmentsStoring allBlocksInstead ] ifNotNil: [ 
		variableToStore instead: assignmentsStoring allBlocksInstead ].
	variableToStore addAfter: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> afterMessageSendTo: aMethod do: aBlock [

	| messageToStore |
	(self messageSendStoring blocksStored includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self messageSendStoring blocksStored at: aMethod.
		aTimeObject addAfter: aBlock.
		^ aTimeObject ].
	self messageSendStoring blocksStored
		at: aMethod
		put: ROCBlocksExecutionOrder new.
	messageToStore := self messageSendStoring blocksStored at: aMethod.
	messageSendStoring allBlocksBefore do: [ :each | 
		messageToStore addBefore: each ].
	messageSendStoring allBlocksAfter do: [ :each | 
		messageToStore addAfter: each ].
	[ messageSendStoring allBlocksInstead ] ifNotNil: [ 
		messageToStore instead: messageSendStoring allBlocksInstead ].
	messageToStore addAfter: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> afterVariableRead: aVariable do: aBlock [

	| variableToStore |
	(self variableReadStoring blocksStored includesKey: aVariable) 
		ifTrue: [ 
			| aTimeObject |
			aTimeObject := self variableReadStoring blocksStored at: aVariable.
			aTimeObject addAfter: aBlock.
			^ aTimeObject ].
	self variableReadStoring blocksStored
		at: aVariable
		put: ROCBlocksExecutionOrder new.
	variableToStore := self variableReadStoring blocksStored at: aVariable.
	variableReadStoring allBlocksBefore do: [ :each | 
		variableToStore addBefore: each ].
	variableReadStoring allBlocksAfter do: [ :each | 
		variableToStore addAfter: each ].
	[ variableReadStoring allBlocksInstead ] ifNotNil: [ 
		variableToStore instead: variableReadStoring allBlocksInstead ].
	variableToStore addAfter: aBlock
]

{ #category : #accessing }
ROCMetaObject >> assignmentsStoring [

	^ assignmentsStoring ifNil: [ assignmentsStoring:= (ROCBlocksRegistry new)  ]
]

{ #category : #accessing }
ROCMetaObject >> assignmentsStoring: anObject [

	assignmentsStoring := anObject
]

{ #category : #'declaration accessing' }
ROCMetaObject >> beforeAnyAssignmentDo: aBlock [

	self assignmentsStoring blocksStored valuesDo: [ :eachValue | 
		eachValue addBefore: aBlock ].
	self assignmentsStoring addAllBlocksBefore: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> beforeAnyMessageSendDo: aBlock [

	self messageSendStoring  blocksStored valuesDo: [ :eachValue | 
		eachValue addBefore: aBlock ].
	self messageSendStoring addAllBlocksBefore: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> beforeAnyVariableReadDo: aBlock [

	self variableReadStoring  blocksStored valuesDo: [ :eachValue | 
		eachValue addBefore: aBlock ].
	self variableReadStoring addAllBlocksBefore: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> beforeAssignmentTo: aVariable do: aBlock [

	| variableToStore |
	(self assignmentsStoring blocksStored includesKey: aVariable) 
		ifTrue: [ 
			^ (self assignmentsStoring blocksStored at: aVariable) addBefore:
				  aBlock ].
	self assignmentsStoring blocksStored
		at: aVariable
		put: ROCBlocksExecutionOrder new.
	variableToStore := self assignmentsStoring blocksStored at: aVariable.
	assignmentsStoring allBlocksBefore do: [ :each | 
		variableToStore addBefore: each ].
	assignmentsStoring allBlocksAfter do: [ :each | 
		variableToStore addAfter: each ].
	[ assignmentsStoring allBlocksInstead ] ifNotNil: [ 
		variableToStore instead: assignmentsStoring allBlocksInstead ].
	variableToStore addBefore: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> beforeMessageSendTo: aMethod do: aBlock [

	| messageToStore |
	
	(self messageSendStoring blocksStored includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self messageSendStoring blocksStored at: aMethod.
		aTimeObject addAfter: aBlock.
		^ aTimeObject ].
	self messageSendStoring blocksStored at: aMethod put: ROCBlocksExecutionOrder new.
	messageToStore := self messageSendStoring blocksStored at: aMethod.
	messageSendStoring allBlocksBefore do: [ :each | 
		messageToStore addBefore: each ].
	messageSendStoring allBlocksAfter do: [ :each | 
		messageToStore addAfter: each ].
	[ messageSendStoring allBlocksInstead ] ifNotNil: [ 
		messageToStore instead: messageSendStoring allBlocksInstead ].
	messageToStore addBefore: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> beforeVariableRead: aVariable do: aBlock [

	| variableToStore |
	(self variableReadStoring blocksStored includesKey: aVariable) 
		ifTrue: [ 
			^ (self variableReadStoring blocksStored at: aVariable) addBefore:
				  aBlock ].
	self variableReadStoring blocksStored
		at: aVariable
		put: ROCBlocksExecutionOrder new.
	variableToStore := self variableReadStoring blocksStored at:
		                   aVariable.
	variableReadStoring allBlocksBefore do: [ :each | 
		variableToStore addBefore: each ].
	variableReadStoring allBlocksAfter do: [ :each | 
		variableToStore addAfter: each ].
	[ variableReadStoring allBlocksInstead ] ifNotNil: [ 
		variableToStore instead: variableReadStoring allBlocksInstead ].
	variableToStore addBefore: aBlock
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

{ #category : #'declaration accessing' }
ROCMetaObject >> insteadAnyAssignmentDo: aBlock [

	self assignmentsStoring blocksStored valuesDo: [ :eachValue | 
		eachValue instead: aBlock ].
	self assignmentsStoring allBlocksInstead: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> insteadAnyMessageSendDo: aBlock [

	self messageSendStoring blocksStored valuesDo: [ :eachValue | 
		eachValue instead: aBlock ].
	self messageSendStoring allBlocksInstead: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> insteadAnyVariableReadDo: aBlock [

	self variableReadStoring blocksStored valuesDo: [ :eachValue | 
		eachValue instead: aBlock ].
	self variableReadStoring allBlocksInstead: aBlock
]

{ #category : #'instance variables' }
ROCMetaObject >> insteadAssignmentTo: aVariable do: aBlock [

	| variableToStore |
	(self assignmentsStoring blocksStored includesKey: aVariable) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self assignmentsStoring blocksStored at: aVariable.
		aTimeObject instead: aBlock.
		^ aTimeObject ].
	variableToStore := self assignmentsStoring blocksStored
		                   at: aVariable
		                   put: ROCBlocksExecutionOrder new.
	variableToStore := self assignmentsStoring blocksStored at: aVariable.
	assignmentsStoring allBlocksBefore do: [ :each | 
		variableToStore addBefore: each ].
	assignmentsStoring allBlocksAfter do: [ :each | 
		variableToStore addAfter: each ].
	variableToStore instead: aBlock
]

{ #category : #'instance variables' }
ROCMetaObject >> insteadMessageSendTo: aMethod do: aBlock [

	| messageToStore |
	(self messageSendStoring blocksStored includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self messageSendStoring blocksStored at: aMethod.
		aTimeObject instead: aBlock.
		^ aTimeObject ].
	messageToStore := self messageSendStoring blocksStored
		                   at: aMethod
		                   put: ROCBlocksExecutionOrder new.
	messageToStore := self messageSendStoring blocksStored at: aMethod.
	messageSendStoring allBlocksBefore do: [ :each | 
		messageToStore addBefore: each ].
	messageSendStoring allBlocksAfter do: [ :each | 
		messageToStore addAfter: each ].
	messageToStore instead: aBlock
]

{ #category : #'instance variables' }
ROCMetaObject >> insteadVariableRead: aVariable do: aBlock [

	| variableToStore |
	(self variableReadStoring blocksStored includesKey: aVariable) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self variableReadStoring blocksStored at: aVariable.
		aTimeObject instead: aBlock.
		^ aTimeObject ].
	variableToStore := self variableReadStoring blocksStored
		                   at: aVariable
		                   put: ROCBlocksExecutionOrder new.
	variableToStore := self variableReadStoring blocksStored at: aVariable.
	variableReadStoring allBlocksBefore do: [ :each | 
		variableToStore addBefore: each ].
	variableReadStoring allBlocksAfter do: [ :each | 
		variableToStore addAfter: each ].
	variableToStore instead: aBlock
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
	[ self assignmentsStoring blocksStored at: operation variable name ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring blocksStored
				at: operation variable name
				put: ROCBlocksExecutionOrder new.
			self assignmentsStoring propagateAllBlocksStored: operation variable name ].
	timeObject := self assignmentsStoring blocksStored at:
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
	[ self messageSendStoring blocksStored at:  aOperation selector ]
		on: KeyNotFound
		do: [ 
			self messageSendStoring blocksStored
				at: aOperation selector
				put: ROCBlocksExecutionOrder new.
			self messageSendStoring propagateAllBlocksStored: aOperation selector ].
	timeObject := self messageSendStoring blocksStored at: aOperation selector.
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
	[ self variableReadStoring blocksStored at: name ]
		on: KeyNotFound
		do: [ 
			self variableReadStoring blocksStored
				at: name
				put: ROCBlocksExecutionOrder new.
			self variableReadStoring propagateAllBlocksStored: name ].
	timeObject := self variableReadStoring blocksStored at: name.
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
ROCMetaObject >> messageSendStoring [

	^ messageSendStoring  ifNil: [ messageSendStoring:= (ROCBlocksRegistry new)  ]
]

{ #category : #accessing }
ROCMetaObject >> messageSendStoring: anObject [

	messageSendStoring := anObject
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

{ #category : #accessing }
ROCMetaObject >> variableReadStoring [

	^ variableReadStoring ifNil: [ variableReadStoring := ROCBlocksRegistry new ]
]

{ #category : #accessing }
ROCMetaObject >> variableReadStoring: anObject [

	variableReadStoring := anObject
]
