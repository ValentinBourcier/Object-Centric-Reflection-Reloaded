Class {
	#name : #RFMessageSendTest,
	#superclass : #TestCase,
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFMessageSendTest >> testAllMessageSendAfter [

	| aMethodTest proxy metaobject |
	aMethodTest := TestClass new.
	proxy := aMethodTest proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aMethodTest var1: 1.
	aMethodTest var2: 2.
	aMethodTest afterAnyMessageSendDo: [ 
		aMethodTest var2: aMethodTest var2 + 1 ].
	aMethodTest sendingMethods.
	self assert: aMethodTest var2 equals: 7
]

{ #category : #tests }
RFMessageSendTest >> testAllMessageSendBefore [

	| aMethodTest proxy metaobject |
	aMethodTest := TestClass new.
	proxy := aMethodTest proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aMethodTest var1: 1.
	aMethodTest var2: 2.
	aMethodTest beforeAnyMessageSendDo: [ 
		aMethodTest var2: aMethodTest var2 + 1 ].
	aMethodTest sendingMethods.
	self assert: aMethodTest var2 equals: 10
]

{ #category : #tests }
RFMessageSendTest >> testAllMessageSendInstead [

	| aMethodTest proxy metaobject |
	aMethodTest := TestClass new.
	proxy := aMethodTest proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aMethodTest var1: 1.
	aMethodTest var2: 2.
	aMethodTest insteadAnyMessageSendDo: [ 
		aMethodTest var2: aMethodTest var2 + 1 ].
	aMethodTest sendingMethods.
	self assert: aMethodTest var2 equals: 4
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendAfter [

	| aMethodTest proxy metaobject |
	aMethodTest := TestClass new.
	proxy := aMethodTest proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aMethodTest var1: 1.
	aMethodTest var2: 2.
	aMethodTest
		afterMessageSendTo: #var2SimpleAsssignment
		do: [ aMethodTest var2: aMethodTest var2 + 1 ].
	aMethodTest sendingMethods .
	self assert: aMethodTest var2 equals: 5
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendBefore [

	| aMethodTest proxy metaobject |
	aMethodTest := TestClass new.
	proxy := aMethodTest proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aMethodTest var1: 1.
	aMethodTest var2: 2.
	aMethodTest
		beforeMessageSendTo: #var2SimpleAsssignment
		do: [ aMethodTest var2: aMethodTest var2 + 1 ].
	aMethodTest sendingMethods.
	self assert: aMethodTest var2 equals: 6
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendInstead [

	| aMethodTest proxy metaobject |
	aMethodTest := TestClass new.
	proxy := aMethodTest proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	Transcript clear.
	aMethodTest var1: 1.
	aMethodTest var2: 2.
	aMethodTest
		insteadMessageSendTo:  #var1SimpleAsssignment
		do: [ aMethodTest var1: aMethodTest var1 + 3 ].
	aMethodTest sendingMethods.
	self assert: aMethodTest var1 equals: 4
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
