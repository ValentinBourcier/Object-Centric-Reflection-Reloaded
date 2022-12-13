Class {
	#name : #ROCBox,
	#superclass : #Object,
	#instVars : [
		'var1',
		'var2',
		'collection'
	],
	#category : #'Reflectivity-Object-Centric-Tests-example'
}

{ #category : #adding }
ROCBox >> add: aValue [

	var1 := var1 + aValue
]

{ #category : #adding }
ROCBox >> addCollection [

	collection
		add: var1;
		add: var2
]

{ #category : #adding }
ROCBox >> addCollectionSumOfValues [

	collection add: var1 + var2
]

{ #category : #adding }
ROCBox >> assigningValues [

	self var1SimpleAsssignment.
	var1 := self returningValue.
	var2 := self returningValue + 8.
	^ self returningValue + 1
]

{ #category : #adding }
ROCBox >> collection [

	^ collection
]

{ #category : #adding }
ROCBox >> collection: anObject [

	collection := anObject
]

{ #category : #adding }
ROCBox >> initialize [

	super initialize.
	self var1: 0.
	self var2: 0.
	self collection: OrderedCollection new
]

{ #category : #adding }
ROCBox >> m1 [

	^ 1
]

{ #category : #adding }
ROCBox >> m2 [

	self m1.
	self m3.
	self m1.
]

{ #category : #adding }
ROCBox >> m3 [

	self m1.

]

{ #category : #adding }
ROCBox >> messageSendOtherObjects [

	self add: 1.
	collection add: 2.
	self add: 3.
	collection add: 4
]

{ #category : #adding }
ROCBox >> onlyAssignment [

	var2 := 2.
	var1 := 9
]

{ #category : #adding }
ROCBox >> readingVariables [

	| value |
	value := var1 + var2 + var1 + var2.
	^ value
]

{ #category : #adding }
ROCBox >> returningValue [

	^ 2
]

{ #category : #adding }
ROCBox >> var1 [

	^ var1
]

{ #category : #adding }
ROCBox >> var1: anObject [

	var1 := anObject
]

{ #category : #adding }
ROCBox >> var1SimpleAsssignment [
	var1 := 7
]

{ #category : #adding }
ROCBox >> var2 [

	^ var2
]

{ #category : #adding }
ROCBox >> var2: anObject [

	var2 := anObject
]

{ #category : #adding }
ROCBox >> variablesReadandAssignment [

	var2 := var1 + var2.
	self var2.
	self var1: 32.
	^ self var1
]

{ #category : #adding }
ROCBox >> variablesReadandAssignmentWithMethodInside [

	var2 := var1 + var2.
	self var2.
	self readingVariables.
	^ self var1
]
