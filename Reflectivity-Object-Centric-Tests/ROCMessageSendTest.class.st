Class {
	#name : #ROCMessageSendTest,
	#superclass : #TestCase,
	#instVars : [
		'proxy',
		'metaobject',
		'aClassTest'
	],
	#category : #'Reflectivity-Object-Centric-Tests-tests'
}

{ #category : #tests }
ROCMessageSendTest >> setUp [

	aClassTest := ROCTestClass new.
	aClassTest var1: 1.
	aClassTest var2: 2.
	aClassTest collection: OrderedCollection new.
	aClassTest result: 0.

]

{ #category : #'tests - after' }
ROCMessageSendTest >> testAllMessageSendAfter [

	aClassTest mop  afterAnyMessageSendDo: [ 
		aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - before' }
ROCMessageSendTest >> testAllMessageSendBefore [

	aClassTest mop beforeAnyMessageSendDo: [ 
		aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - instead' }
ROCMessageSendTest >> testAllMessageSendInstead [

	aClassTest mop insteadAnyMessageSendDo: [ 
		aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - after' }
ROCMessageSendTest >> testMessageSendAfter [

	aClassTest mop 
		afterMessageSend: #var1SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - after' }
ROCMessageSendTest >> testMessageSendAfterNoMethod [

	aClassTest mop 
		afterMessageSend: #var2SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 2
]

{ #category : #'tests - before' }
ROCMessageSendTest >> testMessageSendBefore [

	aClassTest mop 
		beforeMessageSend: #var1SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - before' }
ROCMessageSendTest >> testMessageSendBeforeNoMethod [

	aClassTest mop 
		beforeMessageSend: #var2SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 2
]

{ #category : #'tests - after' }
ROCMessageSendTest >> testMessageSendInAssignmentAfter [

	aClassTest mop afterAnyMessageSendDo: [ 
		aClassTest result: aClassTest result + 1 ].
	self assert: aClassTest assigningValues equals: 3.
	self assert: aClassTest var1 equals: 2.
	self assert: aClassTest var2 equals: 4.
	self assert: aClassTest result equals: 4
]

{ #category : #'tests - before' }
ROCMessageSendTest >> testMessageSendInAssignmentBefore [

	aClassTest mop beforeAnyMessageSendDo: [ 
		aClassTest result: aClassTest result + 1 ].
	self assert: aClassTest assigningValues equals: 3.
	self assert: aClassTest var1 equals: 2.
	self assert: aClassTest var2 equals: 4.
	self assert: aClassTest result equals: 4
]

{ #category : #'tests - instead' }
ROCMessageSendTest >> testMessageSendInAssignmentInstead [


	aClassTest mop insteadAnyMessageSendDo: [ 
		aClassTest result: aClassTest result + 1. 0].
	self assert: aClassTest assigningValues equals: 1.
	self assert: aClassTest var1 equals: 0.
	self assert: aClassTest var2 equals: 8.
	self assert: aClassTest result equals: 4
]

{ #category : #'tests - instead' }
ROCMessageSendTest >> testMessageSendInAssignmentInstead2 [

	aClassTest mop insteadMessageSend: #var1: do:  [ 
		aClassTest result: aClassTest result + 1 ].
	aClassTest assignment2.
	self assert: aClassTest result equals:1.
	self assert: aClassTest var1 equals: 1.
]

{ #category : #'tests - instead' }
ROCMessageSendTest >> testMessageSendInstead [

	aClassTest mop 
		insteadMessageSend: #var1SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - after' }
ROCMessageSendTest >> testMessageSendOtherObjects [

	aClassTest mop 
		afterMessageSend: #add:
		do: [ aClassTest result: aClassTest result + 1 ].
	aClassTest messageSendOtherObjects.
	self assert: aClassTest var1 equals: 5.
	self assert: aClassTest collection size equals: 2.
	self assert: aClassTest result equals: 4
]
