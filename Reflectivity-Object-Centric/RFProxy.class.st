"
I proxify an object:
- I swap all references of that object by me, and all references to me by the object
- I create a meta-object responsible of taking actions upon reception of a message
- I forward every single message to that meta-object, with the exception of the DNU message
"
Class {
	#name : #RFProxy,
	#superclass : #nil,
	#instVars : [
		'target',
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #proxy }
RFProxy class >> becomeTarget: anObject [
	| proxy metaObject|
	proxy := self basicNew.
	anObject become: proxy.
	
	"After the become, proxy and anObject have been swapped"	
	metaObject := RFProxyMetaObject forObject: proxy proxy: anObject.
	MirrorPrimitives fixedFieldOf: anObject at: (self slotNamed: #target) index put: proxy.
	MirrorPrimitives fixedFieldOf: anObject at: (self slotNamed: #metaObject) index put: metaObject.
	
	^ anObject
]

{ #category : #proxy }
RFProxy class >> becomeTarget: anObject  withMetaObject: mo [
	| proxy metaObject newMetaObject|
	proxy := self basicNew.
	anObject become: proxy.
	metaObject  := RFMetaObjectAndOriginalObject new.
	"After the become, proxy and anObject have been swapped"	
	newMetaObject := mo forObject: proxy proxy: anObject.
	metaObject metaObject: newMetaObject .
	MirrorPrimitives fixedFieldOf: anObject at: (self slotNamed: #target) index put: proxy.
	MirrorPrimitives fixedFieldOf: anObject at: (self slotNamed: #metaObject) index put: metaObject metaObject.
	metaObject  object: anObject.
	"Crear un objecto con el return de aqui como accesor"
	^ metaObject 
]

{ #category : #setting }
RFProxy >> afterAnyAssignmentDo: aBlock [

	^ metaObject afterAnyAssignmentDo: aBlock
]

{ #category : #setting }
RFProxy >> afterAnyMessageSendDo: aBlock [

	^ metaObject afterAnyMessageSendDo: aBlock
]

{ #category : #setting }
RFProxy >> afterAnyVariableReadDo: aBlock [

	^ metaObject afterAnyVariableReadDo: aBlock
]

{ #category : #setting }
RFProxy >> afterAssignmentTo: aVariable do: aBlock [

	^ metaObject afterAssignmentTo: aVariable do: aBlock
]

{ #category : #setting }
RFProxy >> afterMessageSendTo: aMethod do: aBlock [

	^ metaObject afterMessageSendTo: aMethod do: aBlock
]

{ #category : #setting }
RFProxy >> afterVariableRead: aVariable do: aBlock [

	^ metaObject afterVariableRead: aVariable do: aBlock
]

{ #category : #setting }
RFProxy >> beforeAnyAssignmentDo: aBlock [

	^ metaObject beforeAnyAssignmentDo: aBlock
]

{ #category : #setting }
RFProxy >> beforeAnyMessageSendDo: aBlock [

	^ metaObject beforeAnyMessageSendDo: aBlock
]

{ #category : #setting }
RFProxy >> beforeAnyVariableReadDo: aBlock [

	^ metaObject beforeAnyVariableReadDo: aBlock
]

{ #category : #setting }
RFProxy >> beforeAssignmentTo: aVariable do: aBlock [

	^ metaObject beforeAssignmentTo: aVariable do: aBlock
]

{ #category : #setting }
RFProxy >> beforeMessageSendTo:  aMethod do: aBlock [

	^ metaObject beforeMessageSendTo: aMethod do: aBlock
]

{ #category : #setting }
RFProxy >> beforeVariableRead: aVariable do: aBlock [

	^ metaObject beforeVariableRead: aVariable do: aBlock
]

{ #category : #'reflective operations' }
RFProxy >> doesNotUnderstand: aMessage [

	<debuggerCompleteToSender>
	'Proxy receiving: ' crTrace.
	aMessage trace.
	^ metaObject
		  send: aMessage selector
		  withArgs: aMessage arguments
		  to: target
]

{ #category : #setting }
RFProxy >> insteadAnyAssignmentDo: aBlock [

	^ metaObject insteadAnyAssignmentDo: aBlock
]

{ #category : #setting }
RFProxy >> insteadAnyMessageSendDo: aBlock [

	^ metaObject insteadAnyMessageSendDo: aBlock
]

{ #category : #setting }
RFProxy >> insteadAnyVariableReadDo: aBlock [

	^ metaObject insteadAnyVariableReadDo: aBlock
]

{ #category : #setting }
RFProxy >> insteadAssignmentTo: aVariable do: aBlock [

	^ metaObject insteadAssignmentTo: aVariable do: aBlock
]

{ #category : #setting }
RFProxy >> insteadMessageSendTo: aMethod do: aBlock [

	^ metaObject insteadMessageSendTo: aMethod do: aBlock
]

{ #category : #setting }
RFProxy >> insteadVariableRead: aVariable do: aBlock [

	^ metaObject insteadVariableRead: aVariable do: aBlock
]
