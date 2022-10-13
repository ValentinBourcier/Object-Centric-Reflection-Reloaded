Class {
	#name : #RFAssignmentTest,
	#superclass : #TestCase,
	#instVars : [
		'aAssignmentTestClass',
		'proxy',
		'metaobject'
	],
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFAssignmentTest >> setUp [

	aAssignmentTestClass := TestClass new.
	aAssignmentTestClass
		var1: 1;
		var2: 0;
		result: 0.
	Transcript clear
]

{ #category : #tests }
RFAssignmentTest >> testAllAssignmentAfter [

	aAssignmentTestClass var1: 0.
	aAssignmentTestClass afterAnyAssignmentDo: [ "aAssignmentTestClass writeSlotNamed: #a value: aAssignmentTestClass a + 1" 
		aAssignmentTestClass var1: aAssignmentTestClass var1 + 1 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass var1 equals: 4.
	self assert: aAssignmentTestClass var2 equals: 2.
	self assert: aAssignmentTestClass result equals: 5
]

{ #category : #tests }
RFAssignmentTest >> testAllAssignmentBefore [

	aAssignmentTestClass var1: 0.

	aAssignmentTestClass beforeAnyAssignmentDo: [ 
		aAssignmentTestClass result: aAssignmentTestClass result + 1 ].
	aAssignmentTestClass onlyAssignment.

	self assert: aAssignmentTestClass var1 equals: 9.
	self assert: aAssignmentTestClass var2 equals: 2.
	self assert: aAssignmentTestClass result equals: 2
]

{ #category : #tests }
RFAssignmentTest >> testAllAssignmentInstead [

	aAssignmentTestClass var1: 0.

	aAssignmentTestClass insteadAnyAssignmentDo: [ 
		aAssignmentTestClass var1: aAssignmentTestClass var1 + 1 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass var1 equals: 3.
	self assert: aAssignmentTestClass var2 equals: 0.
	self assert: aAssignmentTestClass result equals: 0
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentAfter [

	aAssignmentTestClass afterAssignmentTo: #var1 do: [ 
		aAssignmentTestClass result:
			aAssignmentTestClass var1 + aAssignmentTestClass var2 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass result equals: 11
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentBefore [

	aAssignmentTestClass beforeAssignmentTo: #var1 do: [ 
		aAssignmentTestClass result:
			aAssignmentTestClass var1 + aAssignmentTestClass var2 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass result equals: 3
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentInstead [

	aAssignmentTestClass
		insteadAssignmentTo: #var1
		do: [ aAssignmentTestClass var1: 8 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass var1 equals: 8
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentInsteadAllWithAssignment [

	aAssignmentTestClass
		insteadAssignmentTo: #var1
		do: [ aAssignmentTestClass var1: aAssignmentTestClass var1 + 2 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass var1 equals: 3
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentInsteadWithAssignment [

	aAssignmentTestClass
		var1: 0;
		var2: 1.
	aAssignmentTestClass insteadAnyAssignmentDo: [ 
		aAssignmentTestClass var1: aAssignmentTestClass var1 + 5 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass var1 equals: 15
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentStoringDictionary [

	self assert: aAssignmentTestClass var1 equals: 1.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.

	aAssignmentTestClass
		beforeAssignmentTo: #var1
		do: [ 'This is A' crTrace ].
	aAssignmentTestClass
		afterAssignmentTo: #var2
		do: [ 'This is B' crTrace ].
	aAssignmentTestClass
		beforeAssignmentTo: #c
		do: [ 'This is C' crTrace ].
	aAssignmentTestClass
		insteadAssignmentTo: #d
		do: [ 'This is D' crTrace ].

	self assert:
		(metaobject assignmentsStoring valuesStored includesKey: #var2).
	self assert:
		(metaobject assignmentsStoring valuesStored includesKey: #c).
	self assert:
		(metaobject assignmentsStoring valuesStored includesKey: #d).
	self
		assert:
			((metaobject assignmentsStoring valuesStored at: #var1) before at:
				 1) asText
		equals: [ 'This is A' crTrace ] asText.
	self
		assert:
		(metaobject assignmentsStoring valuesStored at: #d) instead asText
		equals: [ 'This is D' crTrace ] asText
]

{ #category : #tests }
RFAssignmentTest >> testBeforeAllAssignmentSelfAssignment [

	"The assignment is executed after doing the operations"

	aAssignmentTestClass var1: 0.
	aAssignmentTestClass beforeAnyAssignmentDo: [ 
		aAssignmentTestClass var1: aAssignmentTestClass var1 + 1 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass var1 equals: 3.
	self assert: aAssignmentTestClass var2 equals: 2.
	self assert: aAssignmentTestClass result equals: 4
]
