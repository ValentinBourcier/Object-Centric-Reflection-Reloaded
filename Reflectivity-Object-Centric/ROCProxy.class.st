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

{ #category : #'configuration building' }
ROCProxy >> afterAnyAssignmentDo: aBlock [

	^ metaObject registryHandler afterAnyAssignmentDo: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> afterAnyMessageSendDo: aBlock [

	^ metaObject registryHandler afterAnyMessageSendDo: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> afterAnyVariableReadDo: aBlock [

	^ metaObject registryHandler afterAnyVariableReadDo: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> afterAssignmentTo: aVariable do: aBlock [

	^ metaObject registryHandler  afterAssignmentTo: aVariable do: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> afterMessageSendTo: aMethod do: aBlock [

	^ metaObject registryHandler afterMessageSendTo: aMethod do: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> afterVariableRead: aVariable do: aBlock [

	^ metaObject registryHandler afterVariableRead: aVariable do: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> beforeAnyAssignmentDo: aBlock [

	^ metaObject registryHandler beforeAnyAssignmentDo: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> beforeAnyMessageSendDo: aBlock [

	^ metaObject registryHandler beforeAnyMessageSendDo: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> beforeAnyVariableReadDo: aBlock [

	^ metaObject registryHandler beforeAnyVariableReadDo: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> beforeAssignmentTo: aVariable do: aBlock [

	^ metaObject registryHandler beforeAssignmentTo: aVariable do: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> beforeMessageSendTo:  aMethod do: aBlock [

	^ metaObject registryHandler beforeMessageSendTo: aMethod do: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> beforeVariableRead: aVariable do: aBlock [

	^ metaObject registryHandler beforeVariableRead: aVariable do: aBlock
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

{ #category : #'configuration building' }
ROCProxy >> insteadAnyAssignmentDo: aBlock [

	^ metaObject registryHandler insteadAnyAssignmentDo: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> insteadAnyMessageSendDo: aBlock [

	^ metaObject registryHandler insteadAnyMessageSendDo: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> insteadAnyVariableReadDo: aBlock [

	^ metaObject registryHandler insteadAnyVariableReadDo: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> insteadAssignmentTo: aVariable do: aBlock [

	^ metaObject registryHandler insteadAssignmentTo: aVariable do: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> insteadMessageSendTo: aMethod do: aBlock [

	^ metaObject registryHandler insteadMessageSendTo: aMethod do: aBlock
]

{ #category : #'configuration building' }
ROCProxy >> insteadVariableRead: aVariable do: aBlock [

	^ metaObject registryHandler insteadVariableRead: aVariable do: aBlock
]
