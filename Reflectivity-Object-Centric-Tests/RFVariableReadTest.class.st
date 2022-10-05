Class {
	#name : #RFVariableReadTest,
	#superclass : #TestCase,
	#instVars : [
		'aTestClass',
		'proxy',
		'metaobject'
	],
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #initialization }
RFVariableReadTest >> setUp [

	aTestClass := TestClass new.
	aTestClass
		var1: 1;
		var2: 0;
		result: 0;
		counter: 0.
	Transcript clear
]

{ #category : #initialization }
RFVariableReadTest >> testAnyVariableRead [

	aTestClass beforeAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 3.
]

{ #category : #initialization }
RFVariableReadTest >> testAnyVariableReadOneVar [

	aTestClass beforeAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 3.
]

{ #category : #initialization }
RFVariableReadTest >> testVariableRead [

	aTestClass beforeVariableRead: #var1 Do: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 3.
]
