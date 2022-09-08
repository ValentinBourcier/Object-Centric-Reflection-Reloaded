Class {
	#name : #RFAssignmentTest,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFAssignmentTest >> testAfterAllAssignment [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := AssignmentsTestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass
		a: 0;
		b: 0;
		result: 0.
	aAssignmentTestClass afterAnyAssignmentDo: [ 
		"aAssignmentTestClass writeSlotNamed: #a value: aAssignmentTestClass a + 1" 
		aAssignmentTestClass a: aAssignmentTestClass a + 1 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass a equals: 4.
	self assert: aAssignmentTestClass b equals: 2.
	self assert: aAssignmentTestClass result equals: 5
]

{ #category : #tests }
RFAssignmentTest >> testAssignment [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 1.
	
	self assert: b a equals: 1.
	b beforeAssignmentTo: #a do: [ 'This is A' crTrace ].
	b afterAssignmentTo: #b do: [ 'This is B' crTrace ].
	b beforeAssignmentTo: #c do: [ 'This is C' crTrace ].
	b insteadAssignmentTo: #d do: [ 'This is D' crTrace ].


	self assert: (metaobject assignmentsStoring valuesStored includesKey: #b).
	self assert: (metaobject assignmentsStoring valuesStored includesKey: #c).
	self assert: (metaobject assignmentsStoring valuesStored includesKey: #d).
	self
		assert: ((metaobject assignmentsStoring valuesStored at: #a) before at: 1) asText
		equals: [ 'This is A' crTrace ] asText.
	self
		assert: ((metaobject assignmentsStoring valuesStored at: #d) instead) asText
		equals: [ 'This is D' crTrace ] asText
		.
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentAfter [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := AssignmentsTestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass a: 1.
	aAssignmentTestClass afterAssignmentTo: #a do: [ 
		aAssignmentTestClass result:
			aAssignmentTestClass a + aAssignmentTestClass b ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass result equals: 11
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentBefore [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := AssignmentsTestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass a: 1.
	aAssignmentTestClass beforeAssignmentTo: #a do: [ 
		aAssignmentTestClass result:
			aAssignmentTestClass a + aAssignmentTestClass b ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass result equals: 3
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentInstead [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := AssignmentsTestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass a: 1.
	aAssignmentTestClass
		insteadAssignmentTo: #a
		do: [ aAssignmentTestClass a: 2 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass a equals: 2
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentInsteadAllWithAssignment [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := AssignmentsTestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass a: 1.
	aAssignmentTestClass
		insteadAssignmentTo: #a
		do: [ aAssignmentTestClass a: aAssignmentTestClass a + 2 ].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass a equals: 3
]

{ #category : #tests }
RFAssignmentTest >> testAssignmentInsteadWithAssignment [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := AssignmentsTestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass
		a: 0;
		b: 1.
	aAssignmentTestClass insteadAnyAssignmentDo: [ 
		aAssignmentTestClass a: aAssignmentTestClass a + 5 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass a equals: 15
]

{ #category : #tests }
RFAssignmentTest >> testBeforeAllAssignment [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := AssignmentsTestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass
		a: 0;
		b: 0;
		result: 0.
	aAssignmentTestClass beforeAnyAssignmentDo: [ 
		aAssignmentTestClass result: aAssignmentTestClass result + 1 ].
	aAssignmentTestClass onlyAssignment.

	self assert: aAssignmentTestClass a equals: 9.
	self assert: aAssignmentTestClass b equals: 2.
	self assert: aAssignmentTestClass result equals: 2
]

{ #category : #tests }
RFAssignmentTest >> testBeforeAllAssignmentSelfAssignment [

	| aAssignmentTestClass proxy metaobject |
	"The assignment is executed after doing the operations"
	aAssignmentTestClass := AssignmentsTestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	aAssignmentTestClass
		a: 0;
		b: 0;
		result: 0.
	aAssignmentTestClass beforeAnyAssignmentDo: [ 
		aAssignmentTestClass a: aAssignmentTestClass a + 1 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass a equals: 3.
	self assert: aAssignmentTestClass b equals: 2.
	self assert: aAssignmentTestClass result equals: 4
]

{ #category : #tests }
RFAssignmentTest >> testInsteadAllAssignment [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := AssignmentsTestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass
		a: 0;
		b: 0;
		result: 0.
	aAssignmentTestClass insteadAnyAssignmentDo: [ 
		aAssignmentTestClass a: aAssignmentTestClass a + 1 ].
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass a equals: 3.
	self assert: aAssignmentTestClass b equals: 0.
	self assert: aAssignmentTestClass result equals: 0
]
