Class {
	#name : #RFAssignmentTest,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFAssignmentTest >> testAllAssignmentAfter [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := TestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass
		var1: 0;
		var2: 0;
		result: 0.
	aAssignmentTestClass afterAnyAssignmentDo: [ 
		"aAssignmentTestClass writeSlotNamed: #a value: aAssignmentTestClass a + 1" 
		aAssignmentTestClass var1: aAssignmentTestClass var1 + 1 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass var1 equals: 4.
	self assert: aAssignmentTestClass var2 equals: 2.
	self assert: aAssignmentTestClass result equals: 5
]

{ #category : #tests }
RFAssignmentTest >> testAllAssignmentBefore [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := TestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass
		var1: 0;
		var2: 0;
		result: 0.
	aAssignmentTestClass beforeAnyAssignmentDo: [ 
		aAssignmentTestClass result: aAssignmentTestClass result + 1 ].
	aAssignmentTestClass onlyAssignment.

	self assert: aAssignmentTestClass var1 equals: 9.
	self assert: aAssignmentTestClass var2 equals: 2.
	self assert: aAssignmentTestClass result equals: 2
]

{ #category : #tests }
RFAssignmentTest >> testAllAssignmentInstead [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := TestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass
		var1: 0;
		var2: 0;
		result: 0.
	aAssignmentTestClass insteadAnyAssignmentDo: [ 
		aAssignmentTestClass var1: aAssignmentTestClass var1 + 1 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass var1 equals: 3.
	self assert: aAssignmentTestClass var2 equals: 0.
	self assert: aAssignmentTestClass result equals: 0
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentAfter [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := TestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass var1: 1.
	aAssignmentTestClass afterAssignmentTo: #var1 do: [ 
		aAssignmentTestClass result:
			aAssignmentTestClass var1 + aAssignmentTestClass var2 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass result equals: 11
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentBefore [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := TestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass var1: 1.
	aAssignmentTestClass beforeAssignmentTo: #var1 do: [ 
		aAssignmentTestClass result:
			aAssignmentTestClass var1 + aAssignmentTestClass var2 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass result equals: 3
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentInstead [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := TestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass var1: 1.
	aAssignmentTestClass
		insteadAssignmentTo: #var1
		do: [ aAssignmentTestClass var1: 2 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass var1 equals: 2
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentInsteadAllWithAssignment [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := TestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass var1: 1.
	aAssignmentTestClass
		insteadAssignmentTo: #var1
		do: [ aAssignmentTestClass var1: aAssignmentTestClass var1 + 2 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass var1 equals: 3
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentInsteadWithAssignment [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := TestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
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

	| b proxy metaobject |
	b := TestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b var1: 1.
	
	self assert: b var1 equals: 1.
	b beforeAssignmentTo: #var1 do: [ 'This is A' crTrace ].
	b afterAssignmentTo: #var2 do: [ 'This is B' crTrace ].
	b beforeAssignmentTo: #c do: [ 'This is C' crTrace ].
	b insteadAssignmentTo: #d do: [ 'This is D' crTrace ].


	self assert: (metaobject assignmentsStoring valuesStored includesKey: #var2).
	self assert: (metaobject assignmentsStoring valuesStored includesKey: #c).
	self assert: (metaobject assignmentsStoring valuesStored includesKey: #d).
	self
		assert: ((metaobject assignmentsStoring valuesStored at: #var1) before at: 1) asText
		equals: [ 'This is A' crTrace ] asText.
	self
		assert: ((metaobject assignmentsStoring valuesStored at: #d) instead) asText
		equals: [ 'This is D' crTrace ] asText
		.
]

{ #category : #tests }
RFAssignmentTest >> testBeforeAllAssignmentSelfAssignment [

	| aAssignmentTestClass proxy metaobject |
	"The assignment is executed after doing the operations"
	aAssignmentTestClass := TestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	aAssignmentTestClass
		var1: 0;
		var2: 0;
		result: 0.
	aAssignmentTestClass beforeAnyAssignmentDo: [ 
		aAssignmentTestClass var1: aAssignmentTestClass var1 + 1 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass var1 equals: 3.
	self assert: aAssignmentTestClass var2 equals: 2.
	self assert: aAssignmentTestClass result equals: 4
]
