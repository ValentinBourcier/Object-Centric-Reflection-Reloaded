"
I am a generic meta-object protocol.

I provide a reflective API for standard objects operations:
- assignments
- variable read
- message sends
- message reception

In different time execution:
- before
- instead
- after


A thing that is important to consider is that for the time execution instead we have to be sure that the block to be executed instead one operation of above has a returning value that fit with the context. Here is an example:

aClass >> addTwoValues

	^ var1 + var2
	
aClass insteadAnyVariableReadDo: [ aClasss counter: aClass counter + 1 ].
aClass addTwoValues.


In that case we are going to face a problem because when we do the block instead variable read, the result doesnt know how to do the message ""+"" this is why inside the block we have to return a value that fit it with the context like:


aClass >> addTwoValues

	^ var1 + var2
	
aClass insteadAnyVariableReadDo: [ aClasss counter: aClass counter + 1. 0 ].
aClass addTwoValues.
"
Class {
	#name : #ROCGenericMOP,
	#superclass : #Object,
	#instVars : [
		'metaObject',
		'object'
	],
	#classInstVars : [
		'mopRegistry'
	],
	#category : #'Reflectivity-Object-Centric-meta-object-protocol'
}

{ #category : #'instance creation' }
ROCGenericMOP class >> mopAt: anObject [ 

	^ self mopRegistry at: anObject hash ifAbsentPut: [ self new onObject: anObject ] 
]

{ #category : #accessing }
ROCGenericMOP class >> mopRegistry [
	^ mopRegistry ifNil: [ mopRegistry := WeakKeyDictionary new ]
]

{ #category : #'instance creation' }
ROCGenericMOP class >> on: anObject [

	^ self mopAt: anObject
]

{ #category : #'reflective operations' }
ROCGenericMOP >> afterAnyAssignmentDo: aBlock [

	^ self metaObject registryHandler afterAnyAssignmentDo: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> afterAnyMessageSendDo: aBlock [

	^ self metaObject registryHandler afterAnyMessageSendDo: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> afterAnyVariableReadDo: aBlock [

	^ self metaObject registryHandler afterAnyVariableReadDo: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> afterAssignmentTo: aVariable do: aBlock [

	^ self metaObject registryHandler  afterAssignmentTo: aVariable do: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> afterMessageSend: aMethod do: aBlock [

	^ self metaObject registryHandler afterMessageSend: aMethod do: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> afterVariableRead: aVariable do: aBlock [

	^ self metaObject registryHandler afterVariableRead: aVariable do: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> beforeAnyAssignmentDo: aBlock [

	^ self metaObject registryHandler beforeAnyAssignmentDo: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> beforeAnyMessageSendDo: aBlock [

	^ self metaObject registryHandler beforeAnyMessageSendDo: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> beforeAnyVariableReadDo: aBlock [

	^ self metaObject registryHandler beforeAnyVariableReadDo: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> beforeAssignmentTo: aVariable do: aBlock [

	^ self metaObject registryHandler beforeAssignmentTo: aVariable do: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> beforeMessageSend:  aMethod do: aBlock [

	^ self metaObject registryHandler beforeMessageSend: aMethod do: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> beforeVariableRead: aVariable do: aBlock [

	^ self metaObject registryHandler beforeVariableRead: aVariable do: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> insteadAnyAssignmentDo: aBlock [

	^ self metaObject registryHandler insteadAnyAssignmentDo: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> insteadAnyMessageSendDo: aBlock [

	^ self metaObject registryHandler insteadAnyMessageSendDo: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> insteadAnyVariableReadDo: aBlock [

	^ self metaObject registryHandler insteadAnyVariableReadDo: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> insteadAssignmentTo: aVariable do: aBlock [

	^ self metaObject registryHandler insteadAssignmentTo: aVariable do: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> insteadMessageSend: aMethod do: aBlock [

	^ self metaObject registryHandler insteadMessageSend: aMethod do: aBlock
]

{ #category : #'reflective operations' }
ROCGenericMOP >> insteadVariableRead: aVariable do: aBlock [

	^ self metaObject registryHandler insteadVariableRead: aVariable do: aBlock
]

{ #category : #accessing }
ROCGenericMOP >> metaObject [

	^ metaObject ifNil: [ 
		  self proxifyObject.
		  metaObject ]
]

{ #category : #accessing }
ROCGenericMOP >> object [
	^ object
]

{ #category : #accessing }
ROCGenericMOP >> onObject: anObject [

	object := anObject
]

{ #category : #instrumentation }
ROCGenericMOP >> proxifyObject [

	| proxy |
	proxy := ROCProxy basicNew.

	object become: proxy.

	"After the become, proxy and anObject have been swapped"
	metaObject := ROCMetaObject forObject: proxy proxy: object.
	metaObject instrumentedObjectMop: self.
	MirrorPrimitives
		fixedFieldOf: object
		at: (ROCProxy slotNamed: #target) index
		put: proxy.
	MirrorPrimitives
		fixedFieldOf: object
		at: (ROCProxy slotNamed: #metaObject) index
		put: metaObject
]
