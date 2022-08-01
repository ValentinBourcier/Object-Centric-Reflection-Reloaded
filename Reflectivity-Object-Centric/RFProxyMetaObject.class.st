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
		'metaLevel'
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

{ #category : #'reflective api' }
RFProxyMetaObject >> executeReflectiveOperationsFor: target uponReceptionOf: selector [

	<debuggerCompleteToSender>
		"self haltOnce."
	"self metaLevel ifFalse: [ 
		metaLevel := true.
		 RFObjectCentricBreak new metaObject: self; signal ]."
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

{ #category : #accessing }
RFProxyMetaObject >> instrumenter [

	^ instrumenter ifNil: [ instrumenter := RFProxyInstrumenter for: self ]
]

{ #category : #accessing }
RFProxyMetaObject >> instrumenter: anObject [

	instrumenter := anObject
]

{ #category : #deprecated }
RFProxyMetaObject >> messageReceived: aReflectiveMessageReceive [
]

{ #category : #deprecated }
RFProxyMetaObject >> messageSent: aReflectiveMessageSend [
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

{ #category : #'message passing' }
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
	|arguments|
	arguments := args asOrderedCollection.
	
	self executeReflectiveOperationsFor: target uponReceptionOf: selector.
	
	self class log: 'sendWA: ' , selector printString.
	
	self instrumenter instrumentSelector: selector withArgs: arguments.

	^ MirrorPrimitives
		  withReceiver: target
		  perform: selector
		  withArguments: arguments asArray


]
