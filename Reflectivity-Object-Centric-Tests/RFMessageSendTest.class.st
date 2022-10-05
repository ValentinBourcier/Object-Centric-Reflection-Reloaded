Class {
	#name : #RFMessageSendTest,
	#superclass : #TestCase,
	#instVars : [
		'aMethodTest',
		'proxy',
		'metaobject'
	],
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFMessageSendTest >> setUp [

	aMethodTest := TestClass new.
	aMethodTest var1: 1.
	aMethodTest var2: 2.
	Transcript clear
]

{ #category : #tests }
RFMessageSendTest >> testAllMessageSendAfter [

	aMethodTest afterAnyMessageSendDo: [ 
		aMethodTest var2: aMethodTest var2 + 1 ].
	aMethodTest sendingMethods.
	self assert: aMethodTest var2 equals: 7
]

{ #category : #tests }
RFMessageSendTest >> testAllMessageSendBefore [

	aMethodTest beforeAnyMessageSendDo: [ 
		aMethodTest var2: aMethodTest var2 + 1 ].
	aMethodTest sendingMethods.
	self assert: aMethodTest var2 equals: 10
]

{ #category : #tests }
RFMessageSendTest >> testAllMessageSendInstead [

	aMethodTest insteadAnyMessageSendDo: [ 
		aMethodTest var2: aMethodTest var2 + 1 ].
	aMethodTest sendingMethods.
	self assert: aMethodTest var2 equals: 4
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendAfter [

	aMethodTest
		afterMessageSendTo: #var2SimpleAsssignment
		do: [ aMethodTest var2: aMethodTest var2 + 1 ].
	aMethodTest sendingMethods.
	self assert: aMethodTest var2 equals: 5
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendBefore [

	aMethodTest
		beforeMessageSendTo: #var2SimpleAsssignment
		do: [ aMethodTest var2: aMethodTest var2 + 1 ].
	aMethodTest sendingMethods.
	self assert: aMethodTest var2 equals: 6
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendInAssignment [

	aMethodTest result: 0.
	aMethodTest beforeAnyMessageSendDo: [ 
		aMethodTest result: aMethodTest result + 1 ].
	aMethodTest assigningValues.
	self assert: aMethodTest result equals: 4
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendInstead [

	aMethodTest
		insteadMessageSendTo: #var1SimpleAsssignment
		do: [ aMethodTest var1: aMethodTest var1 + 3 ].
	aMethodTest sendingMethods.
	self assert: aMethodTest var1 equals: 4
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendOtherObjects [

	aMethodTest collection: OrderedCollection new.
	aMethodTest result: 0.
	aMethodTest
		afterMessageSendTo: #add:
		do: [ aMethodTest result: aMethodTest result + 1 ].
	aMethodTest messageSendOtherObjects.
	self assert: aMethodTest result equals: 4
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendStoringDictionary [

	self assert: aMethodTest var1 equals: 1.

	proxy := aMethodTest proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	aMethodTest beforeMessageSendTo: #var1 do: [ 'This is A' crTrace ].
	aMethodTest insteadMessageSendTo: #var2 do: [ 'This is B' crTrace ].
	aMethodTest
		afterMessageSendTo: #result
		do: [ 'This is result' crTrace ].

	self assert:
		(metaobject messagesStoring valuesStored includesKey: #var1).
	self assert:
		(metaobject messagesStoring valuesStored includesKey: #var2).
	self assert:
		(metaobject messagesStoring valuesStored includesKey: #result).
	self
		assert:
			((metaobject messagesStoring valuesStored at: #var1) before at: 1)
				asText
		equals: [ 'This is A' crTrace ] asText.
	self
		assert:
		(metaobject messagesStoring valuesStored at: #var2) instead asText
		equals: [ 'This is B' crTrace ] asText
]
