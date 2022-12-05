"
This class store the execution order of the values stored. These values are blocks to execute. It has a linkedlist for controls after, before and a value for instead:


after: #([],[],[])
before: #([],[],[])
instead: []
"
Class {
	#name : #ROCBlocksExecutionOrder,
	#superclass : #Object,
	#instVars : [
		'before',
		'after',
		'instead'
	],
	#category : #'Reflectivity-Object-Centric-metaobjects'
}

{ #category : #adding }
ROCBlocksExecutionOrder >> addAfter: aBlock [

	self after add: aBlock.
]

{ #category : #adding }
ROCBlocksExecutionOrder >> addBefore: aBlock [

	self before  add: aBlock
]

{ #category : #accessing }
ROCBlocksExecutionOrder >> after [

	^ after ifNil: [ after := (LinkedList new)  ]
]

{ #category : #accessing }
ROCBlocksExecutionOrder >> before [

	^ before ifNil: [ before := (LinkedList new)  ]
]

{ #category : #accessing }
ROCBlocksExecutionOrder >> instead [

	^ instead
]

{ #category : #accessing }
ROCBlocksExecutionOrder >> instead: anObject [

	instead := anObject
]
