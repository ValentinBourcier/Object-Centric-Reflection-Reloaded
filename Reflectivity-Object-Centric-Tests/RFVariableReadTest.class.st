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
		var1: 0;
		var2: 0;
		result: 0;
		counter: 0.
	Transcript clear
]

{ #category : #'tests - after' }
RFVariableReadTest >> testAfterAnyVariableRead [

	aTestClass afterAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass var2 equals: 0.
	self assert: aTestClass result equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - after' }
RFVariableReadTest >> testAfterAnyVariableReadOneVar [

	aTestClass afterAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - after' }
RFVariableReadTest >> testAfterVariableRead [

	aTestClass afterVariableRead: #var1 do: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - after' }
RFVariableReadTest >> testAfterVariableRead2Var [

	aTestClass afterVariableRead: #var1 do: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 1.
]

{ #category : #'tests - before' }
RFVariableReadTest >> testBeforeAnyVariableRead [

	aTestClass beforeAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass var2 equals: 0.
	self assert: aTestClass result equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - before' }
RFVariableReadTest >> testBeforeAnyVariableReadOneVar [

	aTestClass beforeAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - before' }
RFVariableReadTest >> testBeforeVariableRead [

	aTestClass beforeVariableRead: #var1 do: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - before' }
RFVariableReadTest >> testBeforeVariableRead2Var [
	aTestClass beforeVariableRead: #var1 do: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 1.
]

{ #category : #'tests - instead' }
RFVariableReadTest >> testInsteadAnyVariableRead [

	aTestClass insteadAnyVariableReadDo: [ 
		
		aTestClass counter: aTestClass counter + 1 ].
	
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass var2 equals: 0.
	self assert: aTestClass result equals: 0.
	self assert: aTestClass counter equals: 2
]

{ #category : #'tests - instead' }
RFVariableReadTest >> testInsteadAnyVariableReadOneVar [

	aTestClass insteadAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - instead' }
RFVariableReadTest >> testInsteadVariableRead [

	aTestClass insteadVariableRead: #var1 do: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'tests - instead' }
RFVariableReadTest >> testInsteadVariableRead2Var [

	aTestClass insteadVariableRead: #var1 do: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignment.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass counter equals: 1.
]

{ #category : #'tests - after' }
RFVariableReadTest >> testSimpleVariableReading [

	aTestClass afterAnyVariableReadDo: [ 
		aTestClass counter: aTestClass counter + 1 ].
	aTestClass variablesReadandAssignmentToOneVariable.
	self assert: aTestClass var1 equals: 0.
	self assert: aTestClass var2 equals: 0.
	self assert: aTestClass result equals: 0.
	self assert: aTestClass counter equals: 2.
]

{ #category : #'creation tests' }
RFVariableReadTest >> testVariableReadStoringDictionary [

	self assert: aTestClass var1 equals: 0.
	proxy := aTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.

	aTestClass
		beforeVariableRead: #var1
		do: [ 'This is A' crTrace ].
	aTestClass
		afterVariableRead: #var2
		do: [ 'This is B' crTrace ].
	aTestClass
		beforeVariableRead: #c
		do: [ 'This is C' crTrace ].
	aTestClass
		insteadVariableRead: #d
		do: [ 'This is D' crTrace ].

	self assert:
		(metaobject variableReadStoring valuesStored includesKey: #var2).
	self assert:
		(metaobject variableReadStoring valuesStored includesKey: #c).
	self assert:
		(metaobject variableReadStoring valuesStored includesKey: #d).
	self
		assert:
			((metaobject variableReadStoring valuesStored at: #var1) before at:
				 1) asText
		equals: [ 'This is A' crTrace ] asText.
	self
		assert:
		(metaobject variableReadStoring valuesStored at: #d) instead asText
		equals: [ 'This is D' crTrace ] asText
]
