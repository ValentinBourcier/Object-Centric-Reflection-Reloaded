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
		'messagesSend',
		'assignmentsStoring'
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

	self assignmentsStoring assignments valuesDo: [ :eachValue | 
		eachValue addAfter: aBlock ].
	self assignmentsStoring addAllAssignmentsAfter: aBlock.
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> afterAnyMessageSendDo: aBlock [
	self messagesSend valuesDo: [ :eachValue | eachValue addAfter: aBlock ]
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> afterAssignmentTo: aVariable do: aBlock [

	| variableToStore |
	(self assignmentsStoring assignments includesKey: aVariable) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self assignmentsStoring assignments at: aVariable.
		aTimeObject addAfter: aBlock.
		^ aTimeObject ].

	variableToStore := self assignmentsStoring assignments at: aVariable put: RFTimeObject new.
	variableToStore := self assignmentsStoring assignments at: aVariable.
	assignmentsStoring allAssignmentsBefore do: [ :each | 
		variableToStore addBefore: each ].
	assignmentsStoring allAssignmentsAfter do: [ :each | 
		variableToStore addAfter: each ].
	[ assignmentsStoring allAssignmentsInstead ] ifNotNil: [ 
		variableToStore instead: assignmentsStoring allAssignmentsInstead ].
	variableToStore addAfter: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> afterMessageSendTo: aMethod do: aBlock [

	(self messagesSend includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := messagesSend at: aMethod.
		aTimeObject addAfter: aBlock.
		^ aTimeObject ].
	self messagesSend at: aMethod put: (RFTimeObject new
			 addAfter: aBlock;
			 yourself)
]

{ #category : #accessing }
RFProxyMetaObject >> assignmentsStoring [

	^ assignmentsStoring ifNil: [ assignmentsStoring:= (RFAssignmentsStoring new)  ]
]

{ #category : #accessing }
RFProxyMetaObject >> assignmentsStoring: anObject [

	assignmentsStoring := anObject
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> beforeAnyAssignmentDo: aBlock [

	self assignmentsStoring assignments valuesDo: [ :eachValue | 
		eachValue addBefore: aBlock ].
	self assignmentsStoring addAllAssignmentsBefore: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> beforeAnyMessageSendDo: aBlock [

	self messagesSend valuesDo: [ :eachValue | eachValue addBefore:  aBlock ]
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> beforeAssignmentTo: aVariable do: aBlock [

	| variableToStore |
	(self assignmentsStoring assignments includesKey: aVariable) ifTrue: [ 
		^ (self assignmentsStoring assignments at: aVariable) addBefore:
			  aBlock ].
	self assignmentsStoring assignments
		at: aVariable
		put: RFTimeObject new.
	variableToStore := self assignmentsStoring assignments at: aVariable.
	assignmentsStoring allAssignmentsBefore do: [ :each | 
		variableToStore addBefore: each ].
	assignmentsStoring allAssignmentsAfter do: [ :each | 
		variableToStore addAfter: each ].
	[ assignmentsStoring allAssignmentsInstead ] ifNotNil: [ 
		variableToStore instead: assignmentsStoring allAssignmentsInstead ].
	variableToStore addBefore: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> beforeMessageSendTo: aMethod do: aBlock [

	(self messagesSend includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := messagesSend  at: aMethod .
		aTimeObject addBefore:  aBlock.
		^ aTimeObject ].
	self messagesSend  at: aMethod  put: (RFTimeObject new
			 addBefore: aBlock;
			 yourself)
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

	self assignmentsStoring assignments valuesDo: [ :eachValue | 
		eachValue instead: aBlock ].
	self assignmentsStoring allAssignmentsInstead: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> insteadAnyMessageSendDo: aBlock [

	self messagesSend  valuesDo: [ :eachValue | eachValue instead: aBlock ]
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> insteadAssignmentTo: aVariable do: aBlock [

	| variableToStore |
	(self assignmentsStoring assignments includesKey: aVariable) ifTrue: [ 
		| aTimeObject |
		aTimeObject := self assignmentsStoring assignments at: aVariable.
		aTimeObject instead: aBlock.
		^ aTimeObject ].
	variableToStore := self assignmentsStoring assignments
		                   at: aVariable
		                   put: RFTimeObject new.
	variableToStore := self assignmentsStoring assignments at: aVariable.
	assignmentsStoring allAssignmentsBefore do: [ :each | 
		variableToStore addBefore: each ].
	assignmentsStoring allAssignmentsAfter do: [ :each | 
		variableToStore addAfter: each ].
	variableToStore instead: aBlock
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> insteadMessageSendTo: aMethod do: aBlock [

	(self messagesSend includesKey: aMethod) ifTrue: [ 
		| aTimeObject |
		aTimeObject := messagesSend at: aMethod.
		aTimeObject instead: aBlock.
		^ aTimeObject ].
	self messagesSend at: aMethod put: (RFTimeObject new
			 instead: aBlock;
			 yourself)
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
	self halt.
	self metaLevel ifTrue: [ ^ operation value ].
	[ self assignmentsStoring assignments at: operation variable name ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring assignments
				at: operation variable name
				put: RFTimeObject new ].
	timeObject := self assignmentsStoring assignments at:
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
	self halt.
	self metaLevel ifTrue: [ ^ self ].
	[ self assignmentsStoring assignments at: operation variable name ]
		on: KeyNotFound
		do: [ 
			self assignmentsStoring assignments
				at: operation variable name
				put: RFTimeObject new ].
	timeObject := self assignmentsStoring assignments at:
		              operation variable name.
	beforeColl := timeObject before.
	beforeColl ifEmpty: [ ^ self ].
	self metaLevel: true.
	beforeColl do: [ :each | each value ].
	self metaLevel: false
]

{ #category : #'declaration accessing' }
RFProxyMetaObject >> linkInsteadAssignment: operation [

	| timeObject insteadBlock |
	self class log:
		'METAOBJECT INSTEAD receive Variable: ' , operation variable name
		, ' with Value: ' , operation assignedValue printString
		, '  old Value: '
		, (operation variable read: operation object) printString.
	self halt.
	self metaLevel ifTrue: [ ^ operation value ].
	[ self assignmentsStoring assignments at: operation variable name ]
		on: KeyNotFound
		do: [ ^ operation value ].
	timeObject := self assignmentsStoring assignments at:
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

{ #category : #deprecated }
RFProxyMetaObject >> messageSent: aReflectiveMessageSend [
]

{ #category : #accessing }
RFProxyMetaObject >> messagesSend [

	^ messagesSend ifNil: [  messagesSend:=  (Dictionary new) ]
]

{ #category : #accessing }
RFProxyMetaObject >> messagesSend: anObject [

	messagesSend := anObject
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
		, ' with Value: ' , aValue printString, '  old Value: ', aOldValue printString.
	"self send: aValue withArgs: #(  ) to: instrumenter instrumentedObject.
	^ self
		  send: aVariable
		  withArgs: #(  )
		  to: instrumenter instrumentedObject"
	"^ self
		  send: ':='
		  withArgs: #(  )
		  to: instrumenter instrumentedObject"
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

	self executeReflectiveOperationsFor: target uponReceptionOf: selector.

		self instrumenter instrumentSelector: selector withArgs: arguments.
	^ MirrorPrimitives
		  withReceiver: target
		  perform: selector
		  withArguments: arguments asArray
]
