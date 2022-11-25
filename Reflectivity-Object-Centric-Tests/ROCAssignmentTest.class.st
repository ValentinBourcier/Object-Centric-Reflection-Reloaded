Class {
	#name : #ROCAssignmentTest,
	#superclass : #TestCase,
	#instVars : [
		'aAssignmentTestClass',
		'proxy',
		'metaobject'
	],
	#category : #'Reflectivity-Object-Centric-Tests-tests'
}

{ #category : #tests }
ROCAssignmentTest >> setUp [

	aAssignmentTestClass := ROCTestClass new.
	aAssignmentTestClass
		var1: 0;
		var2: 1;
		result: 0.

]

{ #category : #tests }
ROCAssignmentTest >> testAllAssignmentAfter [

	aAssignmentTestClass mop afterAnyAssignmentDo: [ "aAssignmentTestClass writeSlotNamed: #a value: aAssignmentTestClass a + 1" 
		aAssignmentTestClass var1: aAssignmentTestClass var1 + 1 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass var1 equals: 4.
	self assert: aAssignmentTestClass var2 equals: 2.
	self assert: aAssignmentTestClass result equals: 5
]

{ #category : #tests }
ROCAssignmentTest >> testAllAssignmentBefore [

	aAssignmentTestClass mop beforeAnyAssignmentDo: [ 
		aAssignmentTestClass result: aAssignmentTestClass result + 1 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass var1 equals: 9.
	self assert: aAssignmentTestClass var2 equals: 2.
	self assert: aAssignmentTestClass result equals: 2
]

{ #category : #tests }
ROCAssignmentTest >> testAllAssignmentInstead [

	aAssignmentTestClass mop insteadAnyAssignmentDo: [ 
		aAssignmentTestClass result: aAssignmentTestClass result + 1 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass var1 equals: 0.
	self assert: aAssignmentTestClass var2 equals: 1.
	self assert: aAssignmentTestClass result equals: 2
]

{ #category : #tests }
ROCAssignmentTest >> testAssignmentAfter [

	aAssignmentTestClass mop afterAssignmentTo: #var1 do: [ 
		aAssignmentTestClass result:
			aAssignmentTestClass var1 + aAssignmentTestClass var2 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass result equals: 11
]

{ #category : #tests }
ROCAssignmentTest >> testAssignmentBefore [

	aAssignmentTestClass mop 
		beforeAssignmentTo: #var1
		do: [ aAssignmentTestClass result: aAssignmentTestClass result + 1 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass var1 equals: 9.
	self assert: aAssignmentTestClass var2 equals: 2.
	self assert: aAssignmentTestClass result equals: 1
]

{ #category : #tests }
ROCAssignmentTest >> testAssignmentInstead [

	aAssignmentTestClass mop 
		insteadAssignmentTo: #var1
		do: [ aAssignmentTestClass result: aAssignmentTestClass result + 1 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass var1 equals: 0.
	self assert: aAssignmentTestClass var2 equals: 2.
	self assert: aAssignmentTestClass result equals: 1
]

{ #category : #tests }
ROCAssignmentTest >> testAssignmentInsteadAllWithAssignment [

	aAssignmentTestClass mop 
		insteadAssignmentTo: #var1
		do: [ aAssignmentTestClass var1: aAssignmentTestClass var1 + 2 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass var1 equals: 2
]

{ #category : #tests }
ROCAssignmentTest >> testAssignmentInsteadWithAssignment [

	aAssignmentTestClass mop insteadAnyAssignmentDo: [ 
		aAssignmentTestClass var1: aAssignmentTestClass var1 + 5 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass var1 equals: 15
]

{ #category : #tests }
ROCAssignmentTest >> testBeforeAllAssignmentSelfAssignment [

	"The assignment is executed after doing the operations"

	aAssignmentTestClass mop beforeAnyAssignmentDo: [ 
		aAssignmentTestClass var1: aAssignmentTestClass var1 + 1 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass var1 equals: 3.
	self assert: aAssignmentTestClass var2 equals: 2.
	self assert: aAssignmentTestClass result equals: 4
]
