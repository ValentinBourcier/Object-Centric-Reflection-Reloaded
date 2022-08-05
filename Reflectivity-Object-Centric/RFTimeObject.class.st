Class {
	#name : #RFTimeObject,
	#superclass : #Object,
	#instVars : [
		'before',
		'after',
		'instead'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #accessing }
RFTimeObject >> addAfter: aBlock [

	self after add: aBlock.
]

{ #category : #accessing }
RFTimeObject >> addBefore: aBlock [

	self before  add: aBlock
]

{ #category : #accessing }
RFTimeObject >> after [

	^ after ifNil: [ after := (LinkedList new)  ]
]

{ #category : #accessing }
RFTimeObject >> before [

	^ before ifNil: [ before := (LinkedList new)  ]
]

{ #category : #accessing }
RFTimeObject >> instead [

	^ instead
]

{ #category : #accessing }
RFTimeObject >> instead: anObject [

	instead := anObject
]
