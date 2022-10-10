"
I intercept all message passing sent to my proxy.

If the message is received through an interceptor (RFMessageInterceptor), I first instrument the code of the method corresponding to the message selector, then I send that message to the proxy.

If the message is received through the proxy (either directly or because I sent it to the proxy), I first execute reflective actions then I forward the message to the real object.

To instrument methods, I use an instance of RFProxyInstrumenter.
"
Class {
	#name : #RFProxyMetaObject,
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
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #'instance creation' }
RFProxyMetaObject class >> forObject: anObject proxy: aProxy [

	^ self new forObject: anObject proxy: aProxy
]

{ #category : #logging }
RFProxyMetaObject class >> log: info [

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
RFProxyMetaObject >> afterAnyAssignmentDo: aBlock [

	self assignmentsStoring valuesStored valuesDo: [ :eachValue | 
		eachValue addAfter: aBlock ].
	self assignmentsStoring addAllValuesAfter: aBlock.
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> afterAnyMessageSendDo: aBlock [

	self messageSendStoring valuesStored valuesDo: [ :eachValue | 
		eachValue addAfter: aBlock ].
	self messageSendStoring addAllValuesAfter: aBlock.
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> afterAnyVariableReadDo: aBlock [

	self variableReadStoring valuesStored valuesDo: [ :eachValue | 
		eachValue addAfter: aBlock ].
	self variableReadStoring addAllValuesAfter: aBlock.
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> afterAssignmentTo: aVariable do: aBlock [

	| variableToStore |
	(self assignmentsStoring valuesStored includesKey: aVariable) 
		ifTrue: [ 
			| aTimeObject |
			aTimeObject := self assignmentsStoring valuesStored at: aVariable.
			aTimeObject addAfter: aBlock.
			^ aTimeObject ].
	self assignmentsStoring valuesStored
		at: aVariable
		put: RFControlStoreObject new.
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
RFProxyMetaObject >> afterMessageSendTo: aMethod do: aBlock [

	| messageToStore |
	(self messageSendStoring valuesStored includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self messageSendStoring valuesStored at: aMethod.
		aTimeObject addAfter: aBlock.
		^ aTimeObject ].
	self messageSendStoring valuesStored
		at: aMethod
		put: RFControlStoreObject new.
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
RFProxyMetaObject >> afterVariableRead: aVariable do: aBlock [

	| variableToStore |
	(self variableReadStoring valuesStored includesKey: aVariable) 
		ifTrue: [ 
			| aTimeObject |
			aTimeObject := self variableReadStoring valuesStored at: aVariable.
			aTimeObject addAfter: aBlock.
			^ aTimeObject ].
	self variableReadStoring valuesStored
		at: aVariable
		put: RFControlStoreObject new.
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
RFProxyMetaObject >> assignmentsStoring [

	^ assignmentsStoring ifNil: [ assignmentsStoring:= (RFStore new)  ]
]

{ #category : #accessing }
RFProxyMetaObject >> assignmentsStoring: anObject [

	assignmentsStoring := anObject
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> beforeAnyAssignmentDo: aBlock [

	self assignmentsStoring valuesStored valuesDo: [ :eachValue | 
		eachValue addBefore: aBlock ].
	self assignmentsStoring addAllValuesBefore: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> beforeAnyMessageSendDo: aBlock [

	self messageSendStoring  valuesStored valuesDo: [ :eachValue | 
		eachValue addBefore: aBlock ].
	self messageSendStoring addAllValuesBefore: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> beforeAnyVariableReadDo: aBlock [

	self variableReadStoring  valuesStored valuesDo: [ :eachValue | 
		eachValue addBefore: aBlock ].
	self variableReadStoring addAllValuesBefore: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> beforeAssignmentTo: aVariable do: aBlock [

	| variableToStore |
	(self assignmentsStoring valuesStored includesKey: aVariable) 
		ifTrue: [ 
			^ (self assignmentsStoring valuesStored at: aVariable) addBefore:
				  aBlock ].
	self assignmentsStoring valuesStored
		at: aVariable
		put: RFControlStoreObject new.
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
RFProxyMetaObject >> beforeMessageSendTo: aMethod do: aBlock [

	| messageToStore |
	
	(self messageSendStoring valuesStored includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self messageSendStoring valuesStored at: aMethod.
		aTimeObject addAfter: aBlock.
		^ aTimeObject ].
	self messageSendStoring valuesStored at: aMethod put: RFControlStoreObject new.
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
RFProxyMetaObject >> beforeVariableRead: aVariable do: aBlock [

	| variableToStore |
	(self variableReadStoring valuesStored includesKey: aVariable) 
		ifTrue: [ 
			^ (self variableReadStoring valuesStored at: aVariable) addBefore:
				  aBlock ].
	self variableReadStoring valuesStored
		at: aVariable
		put: RFControlStoreObject new.
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
RFProxyMetaObject >> executeReflectiveOperationsFor: target uponReceptionOf: selector [

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
RFProxyMetaObject >> forObject: anObject [

	self instrumenter beForObject: anObject
]

{ #category : #initialization }
RFProxyMetaObject >> forObject: anObject proxy: aProxy [

	self forObject: anObject.
	self proxy: aProxy
]

{ #category : #deprecated }
RFProxyMetaObject >> instVarAccess: anInstVarAccess [
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> insteadAnyAssignmentDo: aBlock [

	self assignmentsStoring valuesStored valuesDo: [ :eachValue | 
		eachValue instead: aBlock ].
	self assignmentsStoring allValuesInstead: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> insteadAnyMessageSendDo: aBlock [

	self messageSendStoring valuesStored valuesDo: [ :eachValue | 
		eachValue instead: aBlock ].
	self messageSendStoring allValuesInstead: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> insteadAnyVariableReadDo: aBlock [

	self variableReadStoring valuesStored valuesDo: [ :eachValue | 
		eachValue instead: aBlock ].
	self variableReadStoring allValuesInstead: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> insteadAssignmentTo: aVariable do: aBlock [

	| variableToStore |
	(self assignmentsStoring valuesStored includesKey: aVariable) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self assignmentsStoring valuesStored at: aVariable.
		aTimeObject instead: aBlock.
		^ aTimeObject ].
	variableToStore := self assignmentsStoring valuesStored
		                   at: aVariable
		                   put: RFControlStoreObject new.
	variableToStore := self assignmentsStoring valuesStored at: aVariable.
	assignmentsStoring allValuesBefore do: [ :each | 
		variableToStore addBefore: each ].
	assignmentsStoring allValuesAfter do: [ :each | 
		variableToStore addAfter: each ].
	variableToStore instead: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> insteadMessageSendTo: aMethod do: aBlock [

	| messageToStore |
	(self messageSendStoring valuesStored includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self messageSendStoring valuesStored at: aMethod.
		aTimeObject instead: aBlock.
		^ aTimeObject ].
	messageToStore := self messageSendStoring valuesStored
		                   at: aMethod
		                   put: RFControlStoreObject new.
	messageToStore := self messageSendStoring valuesStored at: aMethod.
	messageSendStoring allValuesBefore do: [ :each | 
		messageToStore addBefore: each ].
	messageSendStoring allValuesAfter do: [ :each | 
		messageToStore addAfter: each ].
	messageToStore instead: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> insteadVariableRead: aVariable do: aBlock [

	| variableToStore |
	(self variableReadStoring valuesStored includesKey: aVariable) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self variableReadStoring valuesStored at: aVariable.
		aTimeObject instead: aBlock.
		^ aTimeObject ].
	variableToStore := self variableReadStoring valuesStored
		                   at: aVariable
		                   put: RFControlStoreObject new.
	variableToStore := self variableReadStoring valuesStored at: aVariable.
	variableReadStoring allValuesBefore do: [ :each | 
		variableToStore addBefore: each ].
	variableReadStoring allValuesAfter do: [ :each | 
		variableToStore addAfter: each ].
	variableToStore instead: aBlock
]

{ #category : #accessing }
RFProxyMetaObject >> instrumenter [

	^ instrumenter ifNil: [ instrumenter := RFProxyInstrumenter for: self ]
]

{ #category : #accessing }
RFProxyMetaObject >> instrumenter: anObject [

	instrumenter := anObject
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkAfterAssignment: aName withValue: aValue [

	| timeObject afterColl |
	self class log:
		'METAOBJECT AFTER receive Variable: ' , aName , ' Value: ' , aValue asString .
	self metaLevel ifTrue: [ ^ aValue ].
	[ self assignmentsStoring valuesStored at: aName ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring valuesStored
				at: aName
				put: RFControlStoreObject new.
			self assignmentsStoring addAllValuesStored: aName ].
	timeObject := self assignmentsStoring valuesStored at: aName.
	afterColl := timeObject after.
	afterColl ifEmpty: [ ^ self ].
	self metaLevel: true.
	afterColl do: [ :each | each value ].
	self metaLevel: false
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkAfterMessageSend: selector withArguments: arguments withReceiver: receiver [

	| timeObject afterColl |
	"self class log: 'METAOBJECT AFTER MessageSend: ' , operation selector."
	self metaLevel ifTrue: [ 
		^ receiver perform: selector withArguments: arguments ].
	[ self messageSendStoring valuesStored at: selector ]
		on: KeyNotFound
		do: [ 
			self messageSendStoring valuesStored
				at: selector
				put: RFControlStoreObject new.
			self messageSendStoring addAllValuesStored: selector ].
	timeObject := self messageSendStoring valuesStored at: selector.
	afterColl := timeObject after.
	afterColl ifEmpty: [ ^ self ].
	self metaLevel: true.
	afterColl do: [ :each | each value ].
	self metaLevel: false
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkAfterVariableRead: name [

	| timeObject afterColl |
	"self class log: 'METAOBJECT BEFORE receive Variable: '
		, operation variable name , ' Value: '
		, operation value asString."
	self metaLevel ifTrue: [ ^ self ]. "self o operation value"
	[ self variableReadStoring valuesStored at: name ]
		on: KeyNotFound
		do: [ 
			self variableReadStoring valuesStored
				at: name
				put: RFControlStoreObject new.
			self variableReadStoring addAllValuesStored: name ].
	timeObject := self variableReadStoring valuesStored at: name.
	afterColl := timeObject after.
	afterColl ifEmpty: [ ^ self ].
	self metaLevel: true.
	afterColl do: [ :each | each value ].
	self metaLevel: false
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkBeforeAssignment: aName withValue: aValue [

	| timeObject beforeColl |
	self class log:
		'METAOBJECT BEFORE receive Variable: ' , aName , ' Value: ' , aValue asString.
	self metaLevel ifTrue: [ ^ aValue ].
	[ self assignmentsStoring valuesStored at: aName ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring valuesStored
				at: aName
				put: RFControlStoreObject new.
			self assignmentsStoring addAllValuesStored: aName ].
	timeObject := self assignmentsStoring valuesStored at: aName.
	beforeColl := timeObject before.
	beforeColl ifEmpty: [ ^ self ].
	self metaLevel: true.
	beforeColl do: [ :each | each value ].
	self metaLevel: false
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkBeforeMessageSend: selector withArguments: arguments [

	| timeObject beforeColl |
	self metaLevel ifTrue: [ ^ self ].
	[ self messageSendStoring valuesStored at: selector ]
		on: KeyNotFound
		do: [ 
			self messageSendStoring valuesStored
				at: selector
				put: RFControlStoreObject new.
			self messageSendStoring addAllValuesStored: selector ].
	timeObject := self messageSendStoring valuesStored at: selector.
	beforeColl := timeObject before.
	beforeColl ifEmpty: [ ^ self ].
	self metaLevel: true.
	beforeColl do: [ :each | each value ].
	self metaLevel: false
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkBeforeVariableRead: name [

	| timeObject beforeColl |
	"self class log: 'METAOBJECT BEFORE receive Variable: '
		, operation variable name , ' Value: '
		, operation value asString."
	self metaLevel ifTrue: [ ^ self ]. "self o operation value"
	[ self variableReadStoring valuesStored at: name ]
		on: KeyNotFound
		do: [ 
			self variableReadStoring valuesStored
				at: name
				put: RFControlStoreObject new.
			self variableReadStoring addAllValuesStored: name ].
	timeObject := self variableReadStoring valuesStored at: name.
	beforeColl := timeObject before.
	beforeColl ifEmpty: [ ^ self ].
	self metaLevel: true.
	beforeColl do: [ :each | each value ].
	self metaLevel: false
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkInsteadAssignment: operation [

	| timeObject insteadBlock |
	self metaLevel ifTrue: [ ^ operation value ].
	[ self assignmentsStoring valuesStored at: operation variable name ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring valuesStored
				at: operation variable name
				put: RFControlStoreObject new.
			self assignmentsStoring addAllValuesStored: operation variable name ].
	timeObject := self assignmentsStoring valuesStored at:
		              operation variable name.
	insteadBlock := timeObject instead.
	insteadBlock ifNil: [ ^ operation value ].
	self metaLevel: true.
	insteadBlock value.
	self metaLevel: false
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkInsteadAssignment: aName withValue: aValue [

	| timeObject insteadBlock |
	
	self metaLevel ifTrue: [ ^ aValue ].
	[ self assignmentsStoring valuesStored at: aName ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring valuesStored
				at: aName
				put: RFControlStoreObject new.
			self assignmentsStoring addAllValuesStored: aName ].
	timeObject := self assignmentsStoring valuesStored at: aName.
	insteadBlock := timeObject instead.
	insteadBlock ifNil: [ ^ self].
	self metaLevel: true.
	insteadBlock value.
	self metaLevel: false
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkInsteadMessageSend: selector withArguments: arguments withReceiver: receiver [

	| timeObject insteadBlock |
	self metaLevel ifTrue: [ 
		^ receiver perform: selector withArguments: arguments
		"^ operation value" ].
	[ self messageSendStoring valuesStored at: selector ]
		on: KeyNotFound
		do: [ 
			self messageSendStoring valuesStored
				at: selector
				put: RFControlStoreObject new.
			self messageSendStoring addAllValuesStored: selector.
			^ receiver perform: selector withArguments: arguments
			"^ operation value" ].
	timeObject := self messageSendStoring valuesStored at: selector.
	insteadBlock := timeObject instead.
	insteadBlock ifNil: [ 
		^ receiver perform: selector withArguments: arguments "^ operation value " ].
	self metaLevel: true.
	insteadBlock value.
	self metaLevel: false
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkInsteadVariableRead: name [

	| timeObject insteadColl |
	self metaLevel ifTrue: [ ^ self ]. "self o operation value"
	[ self variableReadStoring valuesStored at: name ]
		on: KeyNotFound
		do: [ 
			self variableReadStoring valuesStored
				at: name
				put: RFControlStoreObject new.
			self variableReadStoring addAllValuesStored: name ].
	timeObject := self variableReadStoring valuesStored at: name.
	insteadColl := timeObject instead.
	insteadColl ifNil: [ ^ self ].
	self metaLevel: true.
	insteadColl value.
	self metaLevel: false
]

{ #category : #deprecated }
RFProxyMetaObject >> messageReceived: aReflectiveMessageReceive [
]

{ #category : #accessing }
RFProxyMetaObject >> messageSendStoring [

	^ messageSendStoring  ifNil: [ messageSendStoring:= (RFStore new)  ]
]

{ #category : #accessing }
RFProxyMetaObject >> messageSendStoring: anObject [

	messageSendStoring := anObject
]

{ #category : #accessing }
RFProxyMetaObject >> metaLevel [

	^ metaLevel ifNil: [ metaLevel := false ]
]

{ #category : #accessing }
RFProxyMetaObject >> metaLevel: anObject [

	^ metaLevel := anObject
]

{ #category : #accessing }
RFProxyMetaObject >> proxy [

	^ proxy
]

{ #category : #accessing }
RFProxyMetaObject >> proxy: anObject [

	proxy := anObject
]

{ #category : #'message passing' }
RFProxyMetaObject >> receive: aSelector [
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
RFProxyMetaObject >> receive: aSelector withArgs: args [

	self class log: 'receive w/args: ' , aSelector printString.
	^ self
		  send: aSelector
		  withArgs: args
		  to: instrumenter instrumentedObject
]

{ #category : #deprecated }
RFProxyMetaObject >> receiveAssignment: aVariable withOldValue: aOldValue withValue: aValue [

	<debuggerCompleteToSender>
	self class log:
		'METAOBJECT receive Variable: ' , aVariable printString
		, ' with Value: ' , aValue printString , '  old Value: '
		, aOldValue printString
]

{ #category : #deprecated }
RFProxyMetaObject >> reflectiveEvent: aReflectiveEvent [
	^aReflectiveEvent reflectOn: self
]

{ #category : #deprecated }
RFProxyMetaObject >> send: aMessage to: target [

	
	self class log: 'sendNA: ' , aMessage printString.
	aMessage arguments: aMessage arguments asOrderedCollection. 
	self instrumenter instrumentSelector: aMessage selector withArgs: aMessage arguments.
	aMessage arguments: aMessage arguments asArray.
	self executeReflectiveOperationsFor: target uponReceptionOf: aMessage.
	^ aMessage sendTo: target
]

{ #category : #'message passing' }
RFProxyMetaObject >> send: selector withArgs: args to: target [

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
RFProxyMetaObject >> variableReadStoring [

	^ variableReadStoring ifNil: [ variableReadStoring := RFStore new ]
]

{ #category : #accessing }
RFProxyMetaObject >> variableReadStoring: anObject [

	variableReadStoring := anObject
]
