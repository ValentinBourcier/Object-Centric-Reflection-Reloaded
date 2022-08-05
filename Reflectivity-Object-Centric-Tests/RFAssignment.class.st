Class {
	#name : #RFAssignment,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFAssignment >> testAfterAllAssignment [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 0; b: 0; result: 0.
	b beforeAnyAssignmentDo:  [self a: self a + 1].
	b selfAssignment .
	self assert: b a equals: 3.
	self assert: b b equals: 2.
	self assert: b result equals: 4.
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


	self assert: (metaobject assignments includesKey: #b).
	self assert: (metaobject assignments includesKey: #c).
	self assert: (metaobject assignments includesKey: #d).
	self
		assert: ((metaobject assignments at: #a) at: #before) asText
		equals: [ 'This is A' crTrace ] asText.
	self
		assert: ((metaobject assignments at: #d) at: #instead) asText
		equals: [ 'This is D' crTrace ] asText
]

{ #category : #tests }
RFAssignment >> testAssignmentAfter [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 1.
	b afterAssignmentTo: #a do: [self result: self a + self b].
	b onlyAssignment.
	self assert: b result equals: 5.
	
]

{ #category : #tests }
RFAssignment >> testAssignmentBefore [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 1.
	b beforeAssignmentTo: #a do: [self result: self a + self b].
	b onlyAssignment.
	self assert: b result equals: 2.
	
]

{ #category : #tests }
RFAssignment >> testAssignmentInstead [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 1.
	b insteadAssignmentTo: #a do: [self a: 2].
	b onlyAssignment.
	self assert: b a equals: 2.
	
]

{ #category : #tests }
RFAssignment >> testBeforeAllAssignment [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 0; b: 0; result: 0.
	b beforeAnyAssignmentDo:  [self a: self a + 1].
	b selfAssignment .
	self assert: b a equals: 3.
	self assert: b b equals: 3.
	self assert: b result equals: 6.
]

{ #category : #tests }
RFAssignment >> testInsteadAllAssignment [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 0; b: 0; result: 0.
	b beforeAnyAssignmentDo:  [self a: self a + 1].
	b selfAssignment .
	self assert: b a equals: 3.
	self assert: b b equals: 0.
	self assert: b result equals: 0.
]
