Class {
	#name : #ROCVariableReadTest,
	#superclass : #TestCase,
	#instVars : [
		'aTestClass',
		'proxy',
		'metaobject'
	],
	#category : #'Reflectivity-Object-Centric-Tests-tests'
}

{ #category : #initialization }
ROCVariableReadTest >> setUp [

	aTestClass := ROCTestClass new.
	aTestClass
		var1: 0;
		var2: 0;
		result: 0;
		counter: 0.
	aTestClass enableMop.
	Transcript clear
]

{ #category : #'tests - after' }
ROCVariableReadTest >> testAfterAnyVariableRead [

	aTestClass afterAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass var2 equals: 0.
	self assert: aTestClass result equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - after' }
ROCVariableReadTest >> testAfterAnyVariableReadOneVar [

	aTestClass afterAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - after' }
ROCVariableReadTest >> testAfterVariableRead [

	aTestClass afterVariableRead: #var1 do: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - after' }
ROCVariableReadTest >> testAfterVariableRead2Var [

	aTestClass afterVariableRead: #var1 do: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 1.
]

{ #category : #'tests - before' }
ROCVariableReadTest >> testBeforeAnyVariableRead [

	aTestClass beforeAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass var2 equals: 0.
	self assert: aTestClass result equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - before' }
ROCVariableReadTest >> testBeforeAnyVariableReadOneVar [

	aTestClass beforeAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - before' }
ROCVariableReadTest >> testBeforeVariableRead [

	aTestClass beforeVariableRead: #var1 do: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - before' }
ROCVariableReadTest >> testBeforeVariableRead2Var [
	aTestClass beforeVariableRead: #var1 do: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 1.
]

{ #category : #'tests - instead' }
ROCVariableReadTest >> testInsteadAnyVariableRead [

	aTestClass insteadAnyVariableReadDo: [ 
		
		aTestClass counter: aTestClass counter + 1.
		"aTestClass counter"].
	
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass var2 equals: 0.
	self assert: aTestClass result equals: 0 "3".
	self assert: aTestClass counter equals: 2
]

{ #category : #'tests - instead' }
ROCVariableReadTest >> testInsteadAnyVariableReadOneVar [

	aTestClass insteadAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - instead' }
ROCVariableReadTest >> testInsteadVariableRead [

	aTestClass insteadVariableRead: #var1 do: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - instead' }
ROCVariableReadTest >> testInsteadVariableRead2Var [

	aTestClass insteadVariableRead: #var1 do: [ 
		aTestClass counter: aTestClass counter + 1 .
		"aTestClass counter"].
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 1.
]

{ #category : #'tests - after' }
ROCVariableReadTest >> testSimpleVariableReading [

	aTestClass afterAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass var2 equals: 0.
	self assert: aTestClass result equals: 0.
	self assert: aTestClass counter equals: 2.
]
