Class {
	#name : #RFMessageSendTest,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFMessageSendTest >> testAllMessageSendAfter [

	| b proxy metaobject |
	b := TestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b var1: 0.
	b var2: 0.
	b result: 0.
	b beforeAnyMessageSendDo: [ b var1: b var1 + 1 ].
	b var2Assignment.
	b onlyAssignmentResult.
	b resultAssignment.
	self assert: b result equals: 2.
	self assert: b var1 equals: 0.
	self assert: b var2 equals: 2
]

{ #category : #tests }
RFMessageSendTest >> testAllMessageSendBefore [

	| b proxy metaobject |
	b := TestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b var1: 0.
	b var2: 0.
	b result: 0.
	b beforeAnyMessageSendDo: [ b var1: b var1 + 1 ].
	b var2Assignment.
	b onlyAssignmentResult.
	b resultAssignment.
	self assert: b result equals: 3.
	self assert: b var1 equals: 3.
	self assert: b var2 equals: 1
]

{ #category : #tests }
RFMessageSendTest >> testAllMessageSendInstead [

	| b proxy metaobject |
	b := TestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b var1: 0.
	b var2: 0.
	b result: 0.
	b beforeAnyMessageSendDo: [ b var1: b var1 + 1 ].
	b var2Assignment.
	b onlyAssignmentResult.
	b resultAssignment.
	self assert: b result equals: 0.
	self assert: b var1 equals: 3.
	self assert: b var2 equals: 0
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendAfter [

	| b proxy metaobject |
	b := TestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b var1: 1.
	b var2: 2.
	b afterMessageSendTo: #methodsWithAssignments do: [b var1: 8].
	b methodsWithAssignments.
	self assert: b result equals: 6.
	self assert: b var1 equals: 5.
	
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendBefore [

	| aMethodTest proxy metaobject |
	aMethodTest := TestClass new.
	proxy := aMethodTest proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aMethodTest var1: 1.
	aMethodTest var2: 2.
	aMethodTest beforeMessageSendTo:#sendingMethods do: [ aMethodTest var1: 5 ].
	aMethodTest sendingMethods.
	self assert: aMethodTest result equals: 7
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendInstead [

| b proxy metaobject |
	b := TestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b var1: 1.
	b var2: 2.
	b afterMessageSendTo: #onlyAssignmentResult do: [b result: (b var1 - b var2)].
	b onlyAssignmentResult.
	self assert: b result equals: -1.
	
	
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendStoringDictionary [

	| b proxy metaobject |
	b := TestClass new.
	proxy := b proxifyWithMetaObject: RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	b var1: 1.
	self assert: b var1 equals: 1.
	b beforeMessageSendTo: #var1 do: [ 'This is A' crTrace ].
	b insteadMessageSendTo: #var2 do: [ 'This is B' crTrace ].
	b afterMessageSendTo: #result do: [ 'This is result' crTrace ].

	self assert: (metaobject messagesStoring valuesStored  includesKey: #var2).
	self assert: (metaobject messagesStoring valuesStored includesKey: #var1).
	self assert: (metaobject messagesStoring valuesStored includesKey: #result).
	self
		assert: ((metaobject messagesStoring valuesStored at: #var1) before at:1) asText
		equals: [ 'This is A' crTrace ] asText.
	self
		assert: ((metaobject messagesStoring valuesStored at: #var2) instead) asText
		equals: [ 'This is B' crTrace ] asText
]
