Class {
	#name : #RFMessageSendTest,
	#superclass : #TestCase,
	#instVars : [
		'proxy',
		'metaobject',
		'aClassTest'
	],
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFMessageSendTest >> setUp [

	aClassTest := TestClass new.
	aClassTest var1: 1.
	aClassTest var2: 2.
	Transcript clear
]

{ #category : #'tests - after' }
RFMessageSendTest >> testAllMessageSendAfter [

	aClassTest afterAnyMessageSendDo: [ 
		aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - before' }
RFMessageSendTest >> testAllMessageSendBefore [

	aClassTest beforeAnyMessageSendDo: [ 
		aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - instead' }
RFMessageSendTest >> testAllMessageSendInstead [

	aClassTest insteadAnyMessageSendDo: [ 
		aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - after' }
RFMessageSendTest >> testMessageSendAfter [

	aClassTest
		afterMessageSendTo: #var1SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - after' }
RFMessageSendTest >> testMessageSendAfterNoMethod [

	aClassTest
		afterMessageSendTo: #var2SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 2
]

{ #category : #'tests - before' }
RFMessageSendTest >> testMessageSendBefore [

	aClassTest
		beforeMessageSendTo: #var1SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - before' }
RFMessageSendTest >> testMessageSendBeforeNoMethod [

	aClassTest
		beforeMessageSendTo: #var2SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 2
]

{ #category : #'tests - after' }
RFMessageSendTest >> testMessageSendInAssignmentAfter [

	aClassTest result: 0.
	aClassTest afterAnyMessageSendDo: [ 
		aClassTest result: aClassTest result + 1 ].
	self assert: aClassTest assigningValues equals: 3.
	self assert: aClassTest var1 equals: 2.
	self assert: aClassTest var2 equals: 4.
	self assert: aClassTest result equals: 4
]

{ #category : #'tests - before' }
RFMessageSendTest >> testMessageSendInAssignmentBefore [

	aClassTest result: 0.
	aClassTest beforeAnyMessageSendDo: [ 
		aClassTest result: aClassTest result + 1 ].
	self assert: aClassTest assigningValues equals: 3.
	self assert: aClassTest var1 equals: 2.
	self assert: aClassTest var2 equals: 4.
	self assert: aClassTest result equals: 4
]

{ #category : #'tests - instead' }
RFMessageSendTest >> testMessageSendInAssignmentInstead [

	aClassTest result: 0.
	aClassTest insteadAnyMessageSendDo: [ 
		aClassTest result: aClassTest result + 1 ].
	self assert: aClassTest assigningValues equals: 3.
	self assert: aClassTest var1 equals: 2.
	self assert: aClassTest var2 equals: 4.
	self assert: aClassTest result equals: 4
]

{ #category : #'tests - instead' }
RFMessageSendTest >> testMessageSendInstead [

	aClassTest
		insteadMessageSendTo: #var1SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - after' }
RFMessageSendTest >> testMessageSendOtherObjects [

	aClassTest collection: OrderedCollection new.
	aClassTest result: 0.
	aClassTest
		afterMessageSendTo: #add:
		do: [ aClassTest result: aClassTest result + 1 ].
	aClassTest messageSendOtherObjects.
	self assert: aClassTest var1 equals: 3.
	self assert: aClassTest collection size equals: 2.
	self assert: aClassTest result equals: 4
]

{ #category : #tests }
RFMessageSendTest >> testMessageSendStoringDictionary [

	self assert: aClassTest var1 equals: 1.

	proxy := aClassTest proxifyWithMetaObject:
		         RFProxyMetaObjectAssignmentTest.
	metaobject := proxy metaObject.
	aClassTest beforeMessageSendTo: #var1 do: [ 'This is A' crTrace ].
	aClassTest insteadMessageSendTo: #var2 do: [ 'This is B' crTrace ].
	aClassTest
		afterMessageSendTo: #result
		do: [ 'This is result' crTrace ].

	self assert:
		(metaobject messageSendStoring valuesStored includesKey: #var1).
	self assert:
		(metaobject messageSendStoring valuesStored includesKey: #var2).
	self assert:
		(metaobject messageSendStoring valuesStored includesKey: #result).
	self
		assert:
			((metaobject messageSendStoring valuesStored at: #var1) before at: 1)
				asText
		equals: [ 'This is A' crTrace ] asText.
	self
		assert:
		(metaobject messageSendStoring valuesStored at: #var2) instead asText
		equals: [ 'This is B' crTrace ] asText
]
