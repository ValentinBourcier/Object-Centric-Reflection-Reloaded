Class {
	#name : #RFMessageSendTest,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFMessageSendTest >> testMessageSend [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 1.
	self assert: b a equals: 1.
	b beforeMessageSendTo: #a do: [ 'This is A' crTrace ].
	b insteadMessageSendTo: #b do: [ 'This is B' crTrace ].
	b afterMessageSendTo: #result do: [ 'This is result' crTrace ].

	self assert: (metaobject messagesSend  includesKey: #b).
	self assert: (metaobject messagesSend includesKey: #a).
	self assert: (metaobject messagesSend includesKey: #result).
	self
		assert: ((metaobject messagesSend at: #a) before at:1) asText
		equals: [ 'This is A' crTrace ] asText.
	self
		assert: ((metaobject messagesSend at: #b) instead) asText
		equals: [ 'This is B' crTrace ] asText
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendAfter [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 1.
	b b: 2.
	b afterMessageSendTo: #onlyAssignmentResult do: [self a: 5].
	b onlyAssignmentResult.
	self assert: b result equals: 3.
	self assert: b a equals: 5.
	
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendAllAfter [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 0.
	b b: 0.
	b result: 0.
	b beforeAnyMessageSendDo: [ self a: self a + 1 ].
	b bAssignment.
	b onlyAssignmentResult.
	b resultAssignment.
	self assert: b result equals: 2.
	self assert: b a equals: 0.
	self assert: b b equals: 2
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendAllBefore [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 0.
	b b: 0.
	b result: 0.
	b beforeAnyMessageSendDo: [ self a: self a + 1 ].
	b bAssignment.
	b onlyAssignmentResult.
	b resultAssignment.
	self assert: b result equals: 3.
	self assert: b a equals: 3.
	self assert: b b equals: 1
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendAllInstead [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 0.
	b b: 0.
	b result: 0.
	b beforeAnyMessageSendDo: [ self a: self a + 1 ].
	b bAssignment.
	b onlyAssignmentResult.
	b resultAssignment.
	self assert: b result equals: 0.
	self assert: b a equals: 3.
	self assert: b b equals: 0
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendBefore [

	| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 1.
	b b: 2.
	b afterMessageSendTo: #onlyAssignmentResult do: [ self a: 5 ].
	b onlyAssignmentResult.
	self assert: b result equals: 7
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendInstead [

| b proxy metaobject |
	b := AssignmentsTestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b a: 1.
	b b: 2.
	b afterMessageSendTo: #onlyAssignmentResult do: [self result: (self a - self b)].
	b onlyAssignmentResult.
	self assert: b result equals: -1.
	
	
]
