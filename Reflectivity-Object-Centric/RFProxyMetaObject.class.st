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
		'messagesStoring'
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

	self messagesStoring valuesStored valuesDo: [ :eachValue | 
		eachValue addAfter: aBlock ].
	self messagesStoring addAllValuesAfter: aBlock.
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
	(self messagesStoring valuesStored includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self messagesStoring valuesStored at: aMethod.
		aTimeObject addAfter: aBlock.
		^ aTimeObject ].
	self messagesStoring valuesStored at: aMethod put: RFControlStoreObject new.
	messageToStore := self messagesStoring valuesStored at: aMethod.
	messagesStoring allValuesBefore do: [ :each | 
		messageToStore addBefore: each ].
	messagesStoring allValuesAfter do: [ :each | 
		messageToStore addAfter: each ].
	[ messagesStoring allValuesInstead ] ifNotNil: [ 
		messageToStore instead: assignmentsStoring allValuesInstead ].
	messageToStore addAfter: aBlock
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

	self messagesStoring valuesStored valuesDo: [ :eachValue | 
		eachValue addBefore: aBlock ].
	self messagesStoring addAllValuesBefore: aBlock
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
	
	(self messagesStoring valuesStored includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self messagesStoring valuesStored at: aMethod.
		aTimeObject addAfter: aBlock.
		^ aTimeObject ].
	self messagesStoring valuesStored at: aMethod put: RFControlStoreObject new.
	messageToStore := self messagesStoring valuesStored at: aMethod.
	messagesStoring allValuesBefore do: [ :each | 
		messageToStore addBefore: each ].
	messagesStoring allValuesAfter do: [ :each | 
		messageToStore addAfter: each ].
	[ messagesStoring allValuesInstead ] ifNotNil: [ 
		messageToStore instead: assignmentsStoring allValuesInstead ].
	messageToStore addBefore: aBlock
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

	self messagesStoring valuesStored valuesDo: [ :eachValue | 
		eachValue instead: aBlock ].
	self messagesStoring allValuesInstead: aBlock
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
	(self messagesStoring valuesStored includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self messagesStoring valuesStored at: aMethod.
		aTimeObject instead: aBlock.
		^ aTimeObject ].
	messageToStore := self messagesStoring valuesStored
		                   at: aMethod
		                   put: RFControlStoreObject new.
	messageToStore := self messagesStoring valuesStored at: aMethod.
	assignmentsStoring allValuesBefore do: [ :each | 
		messageToStore addBefore: each ].
	assignmentsStoring allValuesAfter do: [ :each | 
		messageToStore addAfter: each ].
	messageToStore instead: aBlock
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
RFProxyMetaObject >> linkAfterAssignment: operation [

	| timeObject afterColl |
	self class log:
		'METAOBJECT AFTERS receive Variable: ' , operation variable name
		, ' with Value: ' , operation assignedValue printString
		, '  old Value: '
		, (operation variable read: operation object) printString.
	
	self metaLevel ifTrue: [ ^ operation value ].
	[ self assignmentsStoring valuesStored at: operation variable name ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring valuesStored
				at: operation variable name
				put: RFControlStoreObject new.
			self assignmentsStoring addAllValuesStored: operation variable name
			 ].
	timeObject := self assignmentsStoring valuesStored at:
		              operation variable name.
	afterColl := timeObject after.
	afterColl ifEmpty: [ ^ self ].
	self metaLevel: true.
	afterColl do: [ :each | each value ].
	self metaLevel: false
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkBeforeAssignment: operation [

	| timeObject beforeColl |
	self class log:
		'METAOBJECT BEFORE receive Variable: ' , operation variable name
		, ' with Value: ' , operation assignedValue printString
		, '  old Value: '
		, (operation variable read: operation object) printString.

	self metaLevel ifTrue: [ ^ self ].
	[ self assignmentsStoring valuesStored at: operation variable name ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring valuesStored
				at: operation variable name
				put: RFControlStoreObject new.
			self assignmentsStoring addAllValuesStored: operation variable name ].
	timeObject := self assignmentsStoring valuesStored at:
		              operation variable name.
	beforeColl := timeObject before.
	beforeColl ifEmpty: [ ^ self ].
	self metaLevel: true.
	beforeColl do: [ :each | each value ].
	self metaLevel: false
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkBeforeMessageSend: operation [

	self class log:
		'METAOBJECT BEFORE receive Variable: ' , operation variable name
		, ' with Value: ' , operation assignedValue printString
		, '  old Value: '
		, (operation variable read: operation object) printString.


]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkInsteadAssignment: operation [

	| timeObject insteadBlock |
	self class log:
		'METAOBJECT INSTEAD receive Variable: ' , operation variable name
		, ' with Value: ' , operation assignedValue printString
		, '  old Value: '
		, (operation variable read: operation object) printString.
	self metaLevel ifTrue: [ ^ operation value ].
	[ self assignmentsStoring valuesStored at: operation variable name ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring valuesStored
				at: operation variable name
				put: RFControlStoreObject new.
			self assignmentsStoring addAllValuesStored: operation variable name.
			^ operation value ].
	timeObject := self assignmentsStoring valuesStored at:
		              operation variable name.
	insteadBlock := timeObject instead.
	insteadBlock ifNil: [ ^ operation value ].
	self metaLevel: true.
	insteadBlock value.
	self metaLevel: false
]

{ #category : #deprecated }
RFProxyMetaObject >> messageReceived: aReflectiveMessageReceive [
]

{ #category : #accessing }
RFProxyMetaObject >> messagesStoring [

	^ messagesStoring  ifNil: [ messagesStoring:= (RFStore new)  ]
]

{ #category : #accessing }
RFProxyMetaObject >> messagesStoring: anObject [

	messagesStoring := anObject
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

	"self executeReflectiveOperationsFor: target uponReceptionOf: selector."

	self instrumenter instrumentSelector: selector withArgs: arguments.
	^ MirrorPrimitives
		  withReceiver: target
		  perform: selector
		  withArguments: arguments asArray
]
