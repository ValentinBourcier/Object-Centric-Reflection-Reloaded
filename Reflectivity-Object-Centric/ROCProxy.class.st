"
I proxify an object:
- I swap all references of that object by me, and all references to me by the object
- I create a meta-object responsible of taking actions upon reception of a message
- I forward every single message to that meta-object, with the exception of the DNU message
"
Class {
	#name : #ROCProxy,
	#superclass : #nil,
	#instVars : [
		'target',
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric-instrumentation'
}

{ #category : #proxy }
ROCProxy class >> becomeTarget: anObject [
	| proxy metaObject|
	proxy := self basicNew.
	anObject become: proxy.
	
	"After the become, proxy and anObject have been swapped"	
	metaObject := ROCMetaObject forObject: proxy proxy: anObject.
	MirrorPrimitives fixedFieldOf: anObject at: (self slotNamed: #target) index put: proxy.
	MirrorPrimitives fixedFieldOf: anObject at: (self slotNamed: #metaObject) index put: metaObject.
	
	^ anObject
]

{ #category : #proxy }
ROCProxy class >> becomeTarget: anObject  withMetaObject: mo [
	| proxy metaObject newMetaObject|
	proxy := self basicNew.
	anObject become: proxy.
	metaObject  := ROCMetaObjectAndOriginalObject new.
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
ROCProxy >> afterAnyAssignmentDo: aBlock [

	^ metaObject afterAnyAssignmentDo: aBlock
]

{ #category : #setting }
ROCProxy >> afterAnyMessageSendDo: aBlock [

	^ metaObject afterAnyMessageSendDo: aBlock
]

{ #category : #setting }
ROCProxy >> afterAnyVariableReadDo: aBlock [

	^ metaObject afterAnyVariableReadDo: aBlock
]

{ #category : #setting }
ROCProxy >> afterAssignmentTo: aVariable do: aBlock [

	^ metaObject afterAssignmentTo: aVariable do: aBlock
]

{ #category : #setting }
ROCProxy >> afterMessageSendTo: aMethod do: aBlock [

	^ metaObject afterMessageSendTo: aMethod do: aBlock
]

{ #category : #setting }
ROCProxy >> afterVariableRead: aVariable do: aBlock [

	^ metaObject afterVariableRead: aVariable do: aBlock
]

{ #category : #setting }
ROCProxy >> beforeAnyAssignmentDo: aBlock [

	^ metaObject beforeAnyAssignmentDo: aBlock
]

{ #category : #setting }
ROCProxy >> beforeAnyMessageSendDo: aBlock [

	^ metaObject beforeAnyMessageSendDo: aBlock
]

{ #category : #setting }
ROCProxy >> beforeAnyVariableReadDo: aBlock [

	^ metaObject beforeAnyVariableReadDo: aBlock
]

{ #category : #setting }
ROCProxy >> beforeAssignmentTo: aVariable do: aBlock [

	^ metaObject beforeAssignmentTo: aVariable do: aBlock
]

{ #category : #setting }
ROCProxy >> beforeMessageSendTo:  aMethod do: aBlock [

	^ metaObject beforeMessageSendTo: aMethod do: aBlock
]

{ #category : #setting }
ROCProxy >> beforeVariableRead: aVariable do: aBlock [

	^ metaObject beforeVariableRead: aVariable do: aBlock
]

{ #category : #'reflective operations' }
ROCProxy >> doesNotUnderstand: aMessage [

	<debuggerCompleteToSender>
	'Proxy receiving: ' crTrace.
	aMessage trace.
	^ metaObject
		  send: aMessage selector
		  withArgs: aMessage arguments
		  to: target
]

{ #category : #setting }
ROCProxy >> insteadAnyAssignmentDo: aBlock [

	^ metaObject insteadAnyAssignmentDo: aBlock
]

{ #category : #setting }
ROCProxy >> insteadAnyMessageSendDo: aBlock [

	^ metaObject insteadAnyMessageSendDo: aBlock
]

{ #category : #setting }
ROCProxy >> insteadAnyVariableReadDo: aBlock [

	^ metaObject insteadAnyVariableReadDo: aBlock
]

{ #category : #setting }
ROCProxy >> insteadAssignmentTo: aVariable do: aBlock [

	^ metaObject insteadAssignmentTo: aVariable do: aBlock
]

{ #category : #setting }
ROCProxy >> insteadMessageSendTo: aMethod do: aBlock [

	^ metaObject insteadMessageSendTo: aMethod do: aBlock
]

{ #category : #setting }
ROCProxy >> insteadVariableRead: aVariable do: aBlock [

	^ metaObject insteadVariableRead: aVariable do: aBlock
]
