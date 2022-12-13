Class {
	#name : #ROCBoxTest,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests-example'
}

{ #category : #tests }
ROCBoxTest >> testInitialize [

	| aBox |
	aBox := ROCBox new.
	self assert: aBox var1 equals: 0.
	self assert: aBox var2 equals: 0.
	self assert: aBox collection equals: OrderedCollection new.
]

{ #category : #tests }
ROCBoxTest >> testSimpleAnyMessageSend [

	| aBox counter |
	counter := 0.
	aBox := ROCBox new.
	aBox mop beforeAnyMessageSendDo: [ counter := counter + 1 ].
	aBox variablesReadandAssignment.
	self assert: counter equals: 3
]

{ #category : #tests }
ROCBoxTest >> testSimpleAnyMessageSendMethodInside [

	| aBox counter |
	counter := 0.
	aBox := ROCBox new.
	aBox mop beforeAnyMessageSendDo: [ counter := counter + 1 ].
	aBox m2.
	self assert: counter equals: 4
]

{ #category : #tests }
ROCBoxTest >> testSimpleAnyVariableRead [

	| aBox counter |
	counter := 0.
	aBox := ROCBox new.
	aBox mop beforeAnyVariableReadDo: [ counter := counter + 1 ].
	aBox variablesReadandAssignment.
	self assert: counter equals: 2.
]

{ #category : #tests }
ROCBoxTest >> testSimpleAnyVariableReadDifferentObjects [

	| aBox bBox counter |
	counter := 0.
	aBox := ROCBox new.
	bBox := ROCBox new.
	aBox mop beforeAnyVariableReadDo: [ 
		counter := counter + 1.
		aBox addCollection.
		aBox var2: 3 ].
	bBox variablesReadandAssignment.
	self assert: counter equals: 0.
	self assert: aBox var2 equals: 0.
	self assert: aBox collection equals: OrderedCollection new
]

{ #category : #tests }
ROCBoxTest >> testSimpleAnyVariableReadInsideMethods [

	| aBox counter |
	counter := 0.
	aBox := ROCBox new.
	aBox mop beforeAnyVariableReadDo: [ counter := counter + 1 ].
	aBox variablesReadandAssignmentWithMethodInside.
	self assert: counter equals: 7
]

{ #category : #tests }
ROCBoxTest >> testSimpleAnyVariableReadWithMethodInTheBlock [

	| aBox counter |
	counter := 0.
	aBox := ROCBox new.
	aBox mop beforeAnyVariableReadDo: [ 
		counter := counter + 1.
		aBox addCollection.
		aBox var2: 3 ].
	aBox variablesReadandAssignment.
	self assert: counter equals: 2.
	self assert: aBox var2 equals: 3.
	self
		assert: aBox collection
		equals: (OrderedCollection withAll: #( 0 0 0 3 ))
]

{ #category : #tests }
ROCBoxTest >> testSimpleAnyVariableWrite [

	| aBox counter |
	counter := 0.
	aBox := ROCBox new.
	aBox mop beforeAnyAssignmentDo: [ counter := counter + 1 ].
	aBox variablesReadandAssignment.
	self assert: counter equals: 2
]

{ #category : #tests }
ROCBoxTest >> testSimpleAnyVariableWriteMethodInside [

	| aBox counter |
	counter := 0.
	aBox := ROCBox new.
	aBox mop beforeAnyAssignmentDo:  [ counter := counter + 1 ].
	aBox variablesReadandAssignmentWithMethodInside.
	self assert: counter equals: 2
]

{ #category : #tests }
ROCBoxTest >> testSimpleMessageSend [
	| aBox counter |
	counter := 0.
	aBox := ROCBox new.
	aBox mop beforeMessageSend: #var1 do: [ counter := counter + 1 ].
	aBox variablesReadandAssignment.
	self assert: counter equals: 1
]

{ #category : #tests }
ROCBoxTest >> testSimpleVariableRead [

	| aBox counter |
	counter := 0.
	aBox := ROCBox new.
	aBox mop beforeVariableRead: #var1 do: [ counter := counter + 1 ].
	aBox variablesReadandAssignment.
	self assert: counter equals: 1
]

{ #category : #tests }
ROCBoxTest >> testSimpleVariableReadInstead [

	| aBox counter |
	counter := 0.
	aBox := ROCBox new.
	aBox mop insteadVariableRead: #var2 do: [ counter := counter + 1. 7].
	aBox addCollectionSumOfValues.
	self assert: counter equals: 1.
	self
		assert: aBox collection
		equals: (OrderedCollection withAll: #( 7 ))
]

{ #category : #tests }
ROCBoxTest >> testSimpleVariableReadMoreThanOneInstruction [

	| aBox counter counter2|
	counter := 0.
	counter2 := 0.
	aBox := ROCBox new.
	aBox mop beforeVariableRead: #var1 do: [ counter := counter + 1 ].
	aBox mop beforeVariableRead: #var2 do: [ counter2 := counter2 + 1 ].
	aBox variablesReadandAssignment.
	self assert: counter equals: 1.
	self assert: counter2 equals: 1
]

{ #category : #tests }
ROCBoxTest >> testSimpleVariableWrite [

	| aBox counter |
	counter := 0.
	aBox := ROCBox new.
	aBox mop beforeAssignmentTo: #var2 do:   [ counter := counter + 1 ].
	aBox variablesReadandAssignment.
	self assert: counter equals: 1
]
