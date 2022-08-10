Class {
	#name : #RFAssignment,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFAssignment >> testAfterAllAssignment [

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
		aAssignmentTestClass a: aAssignmentTestClass a + 1 ].
	2 halt.
	aAssignmentTestClass selfAssignment.
	self assert: aAssignmentTestClass a equals: 4.
	self assert: aAssignmentTestClass b equals: 2.
	self assert: aAssignmentTestClass result equals: 5
]

{ #category : #tests }
RFAssignment >> testAssignment [

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


	self assert: (metaobject assignmentsStoring assignments includesKey: #b).
	self assert: (metaobject assignmentsStoring assignments includesKey: #c).
	self assert: (metaobject assignmentsStoring assignments includesKey: #d).
	self
		assert: ((metaobject assignmentsStoring assignments at: #a) before at: 1) asText
		equals: [ 'This is A' crTrace ] asText.
	self
		assert: ((metaobject assignmentsStoring assignments at: #d) instead) asText
		equals: [ 'This is D' crTrace ] asText
		.
]

{ #category : #tests }
RFAssignment >> testAssignmentAfter [

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
	self assert: aAssignmentTestClass result equals: 5
]

{ #category : #tests }
RFAssignment >> testAssignmentBefore [

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
RFAssignment >> testAssignmentInstead [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := AssignmentsTestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass a: 1.
	aAssignmentTestClass insteadAssignmentTo: #a do: [aAssignmentTestClass writeSlotNamed: #a value: 2].
	aAssignmentTestClass onlyAssignment.
	self assert: aAssignmentTestClass a equals: 2.
	
]

{ #category : #tests }
RFAssignment >> testBeforeAllAssignment [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := AssignmentsTestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass a: 0; b: 0; result: 0.
	aAssignmentTestClass beforeAnyAssignmentDo:  [aAssignmentTestClass a: aAssignmentTestClass a + 1].
	aAssignmentTestClass selfAssignment .
	self assert: aAssignmentTestClass a equals: 4.
	self assert: aAssignmentTestClass b equals: 3.
	self assert: aAssignmentTestClass result equals: 7.
]

{ #category : #tests }
RFAssignment >> testInsteadAllAssignment [

	| aAssignmentTestClass proxy metaobject |
	aAssignmentTestClass := AssignmentsTestClass new.
	proxy := aAssignmentTestClass proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aAssignmentTestClass a: 0; b: 0; result: 0.
	aAssignmentTestClass beforeAnyAssignmentDo:  [aAssignmentTestClass a: aAssignmentTestClass a + 1].
	aAssignmentTestClass selfAssignment .
	self assert: aAssignmentTestClass a equals: 3.
	self assert: aAssignmentTestClass b equals: 0.
	self assert: aAssignmentTestClass result equals: 0.
]
