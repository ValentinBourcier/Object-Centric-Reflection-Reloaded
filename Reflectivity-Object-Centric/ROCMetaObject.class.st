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

	self assignmentsStoring valuesStored valuesDo: [ :eachValue | 
		eachValue addAfter: aBlock ].
	self assignmentsStoring addAllValuesAfter: aBlock.
]

{ #category : #'declaration accessing' }
ROCMetaObject >> afterAnyMessageSendDo: aBlock [

	self messageSendStoring valuesStored valuesDo: [ :eachValue | 
		eachValue addAfter: aBlock ].
	self messageSendStoring addAllValuesAfter: aBlock.
]

{ #category : #'declaration accessing' }
ROCMetaObject >> afterAnyVariableReadDo: aBlock [

	self variableReadStoring valuesStored valuesDo: [ :eachValue | 
		eachValue addAfter: aBlock ].
	self variableReadStoring addAllValuesAfter: aBlock.
]

{ #category : #'declaration accessing' }
ROCMetaObject >> afterAssignmentTo: aVariable do: aBlock [

	| variableToStore |
	(self assignmentsStoring valuesStored includesKey: aVariable) 
		ifTrue: [ 
			| aTimeObject |
			aTimeObject := self assignmentsStoring valuesStored at: aVariable.
			aTimeObject addAfter: aBlock.
			^ aTimeObject ].
	self assignmentsStoring valuesStored
		at: aVariable
		put: ROCControlStoreObject new.
	variableToStore := self assignmentsStoring valuesStored at: aVariable.
	assignmentsStoring allValuesBefore do: [ :each | 
		variableToStore addBefore: each ].
	assignmentsStoring allValuesAfter do: [ :each | 
		variableToStore addAfter: each ].
	[ assignmentsStoring allValuesInstead ] ifNotNil: [ 
		variableToStore instead: assignmentsStoring allValuesInstead ].
	variableToStore addAfter: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> afterMessageSendTo: aMethod do: aBlock [

	| messageToStore |
	(self messageSendStoring valuesStored includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self messageSendStoring valuesStored at: aMethod.
		aTimeObject addAfter: aBlock.
		^ aTimeObject ].
	self messageSendStoring valuesStored
		at: aMethod
		put: ROCControlStoreObject new.
	messageToStore := self messageSendStoring valuesStored at: aMethod.
	messageSendStoring allValuesBefore do: [ :each | 
		messageToStore addBefore: each ].
	messageSendStoring allValuesAfter do: [ :each | 
		messageToStore addAfter: each ].
	[ messageSendStoring allValuesInstead ] ifNotNil: [ 
		messageToStore instead: messageSendStoring allValuesInstead ].
	messageToStore addAfter: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> afterVariableRead: aVariable do: aBlock [

	| variableToStore |
	(self variableReadStoring valuesStored includesKey: aVariable) 
		ifTrue: [ 
			| aTimeObject |
			aTimeObject := self variableReadStoring valuesStored at: aVariable.
			aTimeObject addAfter: aBlock.
			^ aTimeObject ].
	self variableReadStoring valuesStored
		at: aVariable
		put: ROCControlStoreObject new.
	variableToStore := self variableReadStoring valuesStored at: aVariable.
	variableReadStoring allValuesBefore do: [ :each | 
		variableToStore addBefore: each ].
	variableReadStoring allValuesAfter do: [ :each | 
		variableToStore addAfter: each ].
	[ variableReadStoring allValuesInstead ] ifNotNil: [ 
		variableToStore instead: variableReadStoring allValuesInstead ].
	variableToStore addAfter: aBlock
]

{ #category : #accessing }
ROCMetaObject >> assignmentsStoring [

	^ assignmentsStoring ifNil: [ assignmentsStoring:= (ROCStore new)  ]
]

{ #category : #accessing }
ROCMetaObject >> assignmentsStoring: anObject [

	assignmentsStoring := anObject
]

{ #category : #'declaration accessing' }
ROCMetaObject >> beforeAnyAssignmentDo: aBlock [

	self assignmentsStoring valuesStored valuesDo: [ :eachValue | 
		eachValue addBefore: aBlock ].
	self assignmentsStoring addAllValuesBefore: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> beforeAnyMessageSendDo: aBlock [

	self messageSendStoring  valuesStored valuesDo: [ :eachValue | 
		eachValue addBefore: aBlock ].
	self messageSendStoring addAllValuesBefore: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> beforeAnyVariableReadDo: aBlock [

	self variableReadStoring  valuesStored valuesDo: [ :eachValue | 
		eachValue addBefore: aBlock ].
	self variableReadStoring addAllValuesBefore: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> beforeAssignmentTo: aVariable do: aBlock [

	| variableToStore |
	(self assignmentsStoring valuesStored includesKey: aVariable) 
		ifTrue: [ 
			^ (self assignmentsStoring valuesStored at: aVariable) addBefore:
				  aBlock ].
	self assignmentsStoring valuesStored
		at: aVariable
		put: ROCControlStoreObject new.
	variableToStore := self assignmentsStoring valuesStored at: aVariable.
	assignmentsStoring allValuesBefore do: [ :each | 
		variableToStore addBefore: each ].
	assignmentsStoring allValuesAfter do: [ :each | 
		variableToStore addAfter: each ].
	[ assignmentsStoring allValuesInstead ] ifNotNil: [ 
		variableToStore instead: assignmentsStoring allValuesInstead ].
	variableToStore addBefore: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> beforeMessageSendTo: aMethod do: aBlock [

	| messageToStore |
	
	(self messageSendStoring valuesStored includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self messageSendStoring valuesStored at: aMethod.
		aTimeObject addAfter: aBlock.
		^ aTimeObject ].
	self messageSendStoring valuesStored at: aMethod put: ROCControlStoreObject new.
	messageToStore := self messageSendStoring valuesStored at: aMethod.
	messageSendStoring allValuesBefore do: [ :each | 
		messageToStore addBefore: each ].
	messageSendStoring allValuesAfter do: [ :each | 
		messageToStore addAfter: each ].
	[ messageSendStoring allValuesInstead ] ifNotNil: [ 
		messageToStore instead: messageSendStoring allValuesInstead ].
	messageToStore addBefore: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> beforeVariableRead: aVariable do: aBlock [

	| variableToStore |
	(self variableReadStoring valuesStored includesKey: aVariable) 
		ifTrue: [ 
			^ (self variableReadStoring valuesStored at: aVariable) addBefore:
				  aBlock ].
	self variableReadStoring valuesStored
		at: aVariable
		put: ROCControlStoreObject new.
	variableToStore := self variableReadStoring valuesStored at:
		                   aVariable.
	variableReadStoring allValuesBefore do: [ :each | 
		variableToStore addBefore: each ].
	variableReadStoring allValuesAfter do: [ :each | 
		variableToStore addAfter: each ].
	[ variableReadStoring allValuesInstead ] ifNotNil: [ 
		variableToStore instead: variableReadStoring allValuesInstead ].
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

{ #category : #deprecated }
ROCMetaObject >> instVarAccess: anInstVarAccess [
]

{ #category : #'declaration accessing' }
ROCMetaObject >> insteadAnyAssignmentDo: aBlock [

	self assignmentsStoring valuesStored valuesDo: [ :eachValue | 
		eachValue instead: aBlock ].
	self assignmentsStoring allValuesInstead: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> insteadAnyMessageSendDo: aBlock [

	self messageSendStoring valuesStored valuesDo: [ :eachValue | 
		eachValue instead: aBlock ].
	self messageSendStoring allValuesInstead: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> insteadAnyVariableReadDo: aBlock [

	self variableReadStoring valuesStored valuesDo: [ :eachValue | 
		eachValue instead: aBlock ].
	self variableReadStoring allValuesInstead: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> insteadAssignmentTo: aVariable do: aBlock [

	| variableToStore |
	(self assignmentsStoring valuesStored includesKey: aVariable) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self assignmentsStoring valuesStored at: aVariable.
		aTimeObject instead: aBlock.
		^ aTimeObject ].
	variableToStore := self assignmentsStoring valuesStored
		                   at: aVariable
		                   put: ROCControlStoreObject new.
	variableToStore := self assignmentsStoring valuesStored at: aVariable.
	assignmentsStoring allValuesBefore do: [ :each | 
		variableToStore addBefore: each ].
	assignmentsStoring allValuesAfter do: [ :each | 
		variableToStore addAfter: each ].
	variableToStore instead: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> insteadMessageSendTo: aMethod do: aBlock [

	| messageToStore |
	(self messageSendStoring valuesStored includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self messageSendStoring valuesStored at: aMethod.
		aTimeObject instead: aBlock.
		^ aTimeObject ].
	messageToStore := self messageSendStoring valuesStored
		                   at: aMethod
		                   put: ROCControlStoreObject new.
	messageToStore := self messageSendStoring valuesStored at: aMethod.
	messageSendStoring allValuesBefore do: [ :each | 
		messageToStore addBefore: each ].
	messageSendStoring allValuesAfter do: [ :each | 
		messageToStore addAfter: each ].
	messageToStore instead: aBlock
]

{ #category : #'declaration accessing' }
ROCMetaObject >> insteadVariableRead: aVariable do: aBlock [

	| variableToStore |
	(self variableReadStoring valuesStored includesKey: aVariable) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self variableReadStoring valuesStored at: aVariable.
		aTimeObject instead: aBlock.
		^ aTimeObject ].
	variableToStore := self variableReadStoring valuesStored
		                   at: aVariable
		                   put: ROCControlStoreObject new.
	variableToStore := self variableReadStoring valuesStored at: aVariable.
	variableReadStoring allValuesBefore do: [ :each | 
		variableToStore addBefore: each ].
	variableReadStoring allValuesAfter do: [ :each | 
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

{ #category : #'declaration accessing' }
ROCMetaObject >> linkInsteadAssignment: operation [

	| timeObject insteadBlock |
	self metaLevel ifTrue: [ ^ operation value ].
	[ self assignmentsStoring valuesStored at: operation variable name ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring valuesStored
				at: operation variable name
				put: ROCControlStoreObject new.
			self assignmentsStoring addAllValuesStored: operation variable name ].
	timeObject := self assignmentsStoring valuesStored at:
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

{ #category : #'declaration accessing' }
ROCMetaObject >> linkInsteadAssignment: aName withValue: aValue [

	| timeObject insteadBlock |
	self metaLevel ifTrue: [ ^ aValue ].
	[ self assignmentsStoring valuesStored at: aName ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring valuesStored
				at: aName
				put: ROCControlStoreObject new.
			self assignmentsStoring addAllValuesStored: aName ].
	timeObject := self assignmentsStoring valuesStored at: aName.
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

{ #category : #'declaration accessing' }
ROCMetaObject >> linkInsteadMessageSend: aOperation [

	| timeObject insteadBlock |
	self metaLevel ifTrue: [ ^ aOperation value ].
	[ self messageSendStoring valuesStored at: aOperation selector ]
		on: KeyNotFound
		do: [ 
			self messageSendStoring valuesStored
				at: aOperation selector
				put: ROCControlStoreObject new.
			self messageSendStoring addAllValuesStored: aOperation selector ].
	timeObject := self messageSendStoring valuesStored at:
		              aOperation selector.
	self metaLevel: true.
	timeObject before ifNotEmpty: [ 
		timeObject before do: [ :each | each value ] ].
	timeObject instead
		ifNil: [ insteadBlock := [ aOperation value ] ]
		ifNotNil: [ insteadBlock := [ timeObject instead value ] ].
	timeObject after ifNotEmpty: [ 
		timeObject after do: [ :each | each value ] ].
	self metaLevel: false.
	^ insteadBlock value
]

{ #category : #'declaration accessing' }
ROCMetaObject >> linkInsteadVariableRead: name withValue: aValue [

	| timeObject insteadBlock |
	self metaLevel ifTrue: [ ^ aValue ].
	[ self variableReadStoring valuesStored at: name ]
		on: KeyNotFound
		do: [ 
			self variableReadStoring valuesStored
				at: name
				put: ROCControlStoreObject new.
			self variableReadStoring addAllValuesStored: name ].
	timeObject := self variableReadStoring valuesStored at: name.
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

{ #category : #deprecated }
ROCMetaObject >> messageReceived: aReflectiveMessageReceive [
]

{ #category : #accessing }
ROCMetaObject >> messageSendStoring [

	^ messageSendStoring  ifNil: [ messageSendStoring:= (ROCStore new)  ]
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

{ #category : #deprecated }
ROCMetaObject >> receiveAssignment: aVariable withOldValue: aOldValue withValue: aValue [

	<debuggerCompleteToSender>
	self class log:
		'METAOBJECT receive Variable: ' , aVariable printString
		, ' with Value: ' , aValue printString , '  old Value: '
		, aOldValue printString
]

{ #category : #accessing }
ROCMetaObject >> receiver [

	^ instrumenter instrumentedObject
]

{ #category : #deprecated }
ROCMetaObject >> reflectiveEvent: aReflectiveEvent [
	^aReflectiveEvent reflectOn: self
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
"	self executeReflectiveOperationsFor: target uponReceptionOf: selector."
	self instrumenter instrumentSelector: selector withArgs: arguments.

	^ MirrorPrimitives
		  withReceiver: target
		  perform: selector
		  withArguments: arguments asArray
]

{ #category : #accessing }
ROCMetaObject >> variableReadStoring [

	^ variableReadStoring ifNil: [ variableReadStoring := ROCStore new ]
]

{ #category : #accessing }
ROCMetaObject >> variableReadStoring: anObject [

	variableReadStoring := anObject
]
