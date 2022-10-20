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
	Transcript clear
]

{ #category : #'tests - after' }
ROCMessageSendTest >> testAllMessageSendAfter [

	aClassTest afterAnyMessageSendDo: [ 
		aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - before' }
ROCMessageSendTest >> testAllMessageSendBefore [

	aClassTest beforeAnyMessageSendDo: [ 
		aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - instead' }
ROCMessageSendTest >> testAllMessageSendInstead [

	aClassTest insteadAnyMessageSendDo: [ 
		aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #tests }
ROCMessageSendTest >> testExecute [

	| a proxy |
	a := ROCBottom new.
	proxy := a proxify.
	Transcript clear.
	a mWithSuper.
	a mWithSuper
]

{ #category : #'tests - after' }
ROCMessageSendTest >> testMessageSendAfter [

	aClassTest
		afterMessageSendTo: #var1SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - after' }
ROCMessageSendTest >> testMessageSendAfterNoMethod [

	aClassTest
		afterMessageSendTo: #var2SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 2
]

{ #category : #'tests - before' }
ROCMessageSendTest >> testMessageSendBefore [

	aClassTest
		beforeMessageSendTo: #var1SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - before' }
ROCMessageSendTest >> testMessageSendBeforeNoMethod [

	aClassTest
		beforeMessageSendTo: #var2SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 2
]

{ #category : #'tests - after' }
ROCMessageSendTest >> testMessageSendInAssignmentAfter [

	aClassTest result: 0.
	aClassTest afterAnyMessageSendDo: [ 
		aClassTest result: aClassTest result + 1 ].
	self assert: aClassTest assigningValues equals: 3.
	self assert: aClassTest var1 equals: 2.
	self assert: aClassTest var2 equals: 4.
	self assert: aClassTest result equals: 4
]

{ #category : #'tests - before' }
ROCMessageSendTest >> testMessageSendInAssignmentBefore [

	aClassTest result: 0.
	aClassTest beforeAnyMessageSendDo: [ 
		aClassTest result: aClassTest result + 1 ].
	self assert: aClassTest assigningValues equals: 3.
	self assert: aClassTest var1 equals: 2.
	self assert: aClassTest var2 equals: 4.
	self assert: aClassTest result equals: 4
]

{ #category : #'tests - instead' }
ROCMessageSendTest >> testMessageSendInAssignmentInstead [

	aClassTest result: 0.
	aClassTest insteadAnyMessageSendDo: [ 
		aClassTest result: aClassTest result + 1 ].
	self assert: aClassTest assigningValues equals: 3.
	self assert: aClassTest var1 equals: 2.
	self assert: aClassTest var2 equals: 4.
	self assert: aClassTest result equals: 4
]

{ #category : #'tests - instead' }
ROCMessageSendTest >> testMessageSendInstead [

	aClassTest
		insteadMessageSendTo: #var1SimpleAsssignment
		do: [ aClassTest var2: aClassTest var2 + 1 ].
	aClassTest sendingMethods.
	self assert: aClassTest var2 equals: 4
]

{ #category : #'tests - after' }
ROCMessageSendTest >> testMessageSendOtherObjects [

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
