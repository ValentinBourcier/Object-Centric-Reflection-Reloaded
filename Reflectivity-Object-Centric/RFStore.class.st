Class {
	#name : #RFStore,
	#superclass : #Object,
	#instVars : [
		'valuesStored',
		'allValuesAfter',
		'allValuesInstead',
		'allValuesBefore'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #adding }
RFStore >> addAllValuesAfter: aBlock [

	self allValuesAfter add: aBlock.
]

{ #category : #adding }
RFStore >> addAllValuesBefore: aBlock [

	self allValuesBefore add: aBlock.
]

{ #category : #adding }
RFStore >> addAllValuesStored: aVariable [

	| aTimeObject |
	aTimeObject := valuesStored at: aVariable.
	self allValuesBefore do: [ :each | aTimeObject addBefore: each ].
	self allValuesAfter do: [ :each | aTimeObject addAfter: each ].
	self allValuesInstead ifNotNil: [ 
		aTimeObject instead: allValuesInstead ]
]

{ #category : #accessing }
RFStore >> allValuesAfter [

	^ allValuesAfter  ifNil: [ allValuesAfter := LinkedList   new ]
]

{ #category : #accessing }
RFStore >> allValuesBefore [

	^ allValuesBefore  ifNil: [ allValuesBefore := LinkedList  new ] 
]

{ #category : #accessing }
RFStore >> allValuesInstead [

	^ allValuesInstead
]

{ #category : #accessing }
RFStore >> allValuesInstead: anObject [

	allValuesInstead := anObject
]

{ #category : #accessing }
RFStore >> valuesStored [

	^ valuesStored ifNil: [ valuesStored := (Dictionary new)  ]
]

{ #category : #accessing }
RFStore >> valuesStored: anObject [

	valuesStored := anObject
]
