Class {
	#name : #CaseTest,
	#superclass : #TestCase,
	#instVars : [
		'package'
	],
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #initialization }
CaseTest >> setUp [ 
	super setUp.
	package :=Package new.
	package counter: 0.
	package caseMaterial: 3.
	package calculateCaseWeight.
	package height: 2.
	package width: 1.
	package depth: 0.2.
	package calculateBoxWeight.
	package packageWeight: 0.5.
	package packagePrice: 20.
]

{ #category : #initialization }
CaseTest >> testAnyAssignmentCounter [

	package afterAnyAssignmentDo: [package counter: package counter + 1 ].
	package calculatePackageTax.
	self assert: package counter equals: 2.
]

{ #category : #initialization }
CaseTest >> testAnyMessageSendCounter [

	package afterAnyMessageSendDo: [package counter: package counter + 1 ].
	package clearPackage .
	self assert: package counter equals: 2.
]

{ #category : #initialization }
CaseTest >> testLaunchredirectSelfArgsIn [

	package afterAnyMessageSendDo: [package counter: package counter + 1 ].
	self halt.
	package clearPackage .
	self assert: package counter equals: 2.
]
