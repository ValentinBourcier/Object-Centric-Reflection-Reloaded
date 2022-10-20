Class {
	#name : #ROCMopTest,
	#superclass : #TestCase,
	#instVars : [
		'package'
	],
	#category : #'Reflectivity-Object-Centric-Tests-tests'
}

{ #category : #initialization }
ROCMopTest >> setUp [ 
	super setUp.
	package :=ROCPackage new.
	package counter: 0.
	package caseMaterial: 3.
	package calculateCaseWeight.
	package height: 2.
	package width: 1.
	package depth: 0.2.
	package calculateBoxWeight.
	package packageWeight: 0.5.
	package packagePrice: 20.
	package packageTax: 10.
]

{ #category : #initialization }
ROCMopTest >> testAnyAssignmentAfterCounter [

	package afterAnyAssignmentDo: [ package counter: package counter + 1 ].
	package calculatePackageTax.
	self assert: package counter equals: 2
]

{ #category : #initialization }
ROCMopTest >> testAnyAssignmentBeforeCounter [

	package beforeAnyAssignmentDo: [ 
		package counter: package counter + 1 ].
	package calculatePackageTax.
	self assert: package counter equals: 2
]

{ #category : #initialization }
ROCMopTest >> testAnyAssignmentInsteadCounter [

	package insteadAnyAssignmentDo: [ 
		package counter: package counter + 1 ].
	package calculatePackageTax.
	self assert: package counter equals: 2 
]

{ #category : #initialization }
ROCMopTest >> testAnyMessageSendAfterCounter [

	package afterAnyMessageSendDo: [ 
		package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 2
]

{ #category : #initialization }
ROCMopTest >> testAnyMessageSendBeforeCounter [

	package beforeAnyMessageSendDo: [ 
		package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 2
]

{ #category : #initialization }
ROCMopTest >> testAnyMessageSendInsteadCounter [

	package insteadAnyMessageSendDo: [ 
		package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 2
]

{ #category : #initialization }
ROCMopTest >> testInsideMessageSendBeforeCounter [

	package beforeMessageSendTo:  #m1 do:  [ 
		package counter: package counter + 1 ].
	package m2.
	self assert: package counter equals: 3
]

{ #category : #initialization }
ROCMopTest >> testInsideMessageSendBeforeCounterSelfMessage [

	package
		beforeMessageSendTo: #m1
		do: [ package counter: package counter + 1 ].

	package m1.
	self assert: package counter equals: 0
]

{ #category : #initialization }
ROCMopTest >> testMessageSendAfterFirstInstruction [

	package
		afterMessageSendTo: #setPackagePrice:andTax:
		do: [ package counter: package counter + 1 ].
	
	package setPackagePrice: 5 andTax: 7.
	self assert: package counter equals: 0.
	self assert: package packagePrice equals: 5.
	self assert: package packageTax equals: 7.
]

{ #category : #initialization }
ROCMopTest >> testSpecificAssignmentAfterCounter [

	package
		afterAssignmentTo: #packagePrice
		do: [ package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 1.
	self assert: package packagePrice equals: 0.
	self assert: package packageTax equals: 0
]

{ #category : #initialization }
ROCMopTest >> testSpecificAssignmentBeforeCounter [

	package
		beforeAssignmentTo: #packagePrice
		do: [ package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 1
]

{ #category : #initialization }
ROCMopTest >> testSpecificAssignmentInsteadCounter [

	package
		insteadAssignmentTo: #packagePrice
		do: [ package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 1
]

{ #category : #initialization }
ROCMopTest >> testSpecificMessageSendAfterCounter [

	package afterMessageSendTo:  #clearTaxes do:  [ 
		package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 1
]

{ #category : #initialization }
ROCMopTest >> testSpecificMessageSendBeforeCounter [

	package beforeMessageSendTo:  #clearTaxes do:  [ 
		package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 1
]

{ #category : #initialization }
ROCMopTest >> testSpecificMessageSendInsteadCounter [

	package insteadMessageSendTo: #clearTaxes do:  [ 
		package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 1
]

{ #category : #initialization }
ROCMopTest >> testTwoObjectsMessageSendAfterChangingValueEachOther [

	| opackage |
	opackage := ROCPackage new.
	opackage counter: 0.
	opackage caseMaterial: 3.
	opackage calculateCaseWeight.
	opackage height: 2.
	opackage width: 1.
	opackage depth: 0.2.
	opackage calculateBoxWeight.
	opackage packageWeight: 0.5.
	opackage packagePrice: 20.
	opackage packageTax: 10.
	opackage
		afterMessageSendTo: #packagePrice:
		do: [ package counter: package counter + 1 ].
	opackage clearPackage.
	self assert: opackage counter equals: 0.
	self assert: opackage packagePrice equals: 0.
	self assert: opackage packageTax equals: 0.
	self assert: package counter equals: 1.
	self assert: package packagePrice equals: 20.
	self assert: package packageTax equals: 10.

]

{ #category : #initialization }
ROCMopTest >> testTwoObjectsMessageSendBeforeChangingValueEachOther [

	| opackage |
	opackage := ROCPackage new.
	opackage counter: 0.
	opackage caseMaterial: 3.
	opackage calculateCaseWeight.
	opackage height: 2.
	opackage width: 1.
	opackage depth: 0.2.
	opackage calculateBoxWeight.
	opackage packageWeight: 0.5.
	opackage packagePrice: 20.
	opackage packageTax: 10.
	opackage
		beforeMessageSendTo: #packagePrice:
		do: [ package counter: package counter + 1 ].
	opackage clearPackage.
	self assert: opackage counter equals: 0.
	self assert: opackage packagePrice equals: 0.
	self assert: opackage packageTax equals: 0.
	self assert: package counter equals: 1.
	self assert: package packagePrice equals: 20.
	self assert: package packageTax equals: 10.

]

{ #category : #initialization }
ROCMopTest >> testTwoObjectsMessageSendInstead [

	| opackage |
	opackage := ROCPackage new.
	opackage counter: 0.
	opackage caseMaterial: 3.
	opackage calculateCaseWeight.
	opackage height: 2.
	opackage width: 1.
	opackage depth: 0.2.
	opackage calculateBoxWeight.
	opackage packageWeight: 0.5.
	opackage packagePrice: 20.
	opackage packageTax: 10.
	opackage
		insteadMessageSendTo: #setPackagePrice:andTax:
		do: [ package counter: package counter + 1 ].
	opackage setPackagePrice: 5 andTax: 7.
	self assert: opackage counter equals: 0.
	self assert: package packagePrice equals: 20.
	self assert: package packageTax equals: 10.
	self assert: package counter equals: 0.
	self assert: opackage packagePrice equals: 5.
	self assert: opackage packageTax equals: 7
]

{ #category : #initialization }
ROCMopTest >> testTwoObjectsMessageSendInsteadChangingValueEachOther [

	| opackage |
	opackage := ROCPackage new.
	opackage counter: 0.
	opackage caseMaterial: 3.
	opackage calculateCaseWeight.
	opackage height: 2.
	opackage width: 1.
	opackage depth: 0.2.
	opackage calculateBoxWeight.
	opackage packageWeight: 0.5.
	opackage packagePrice: 20.
	opackage packageTax: 10.
	opackage
		insteadMessageSendTo: #packagePrice:
		do: [ package counter: package counter + 1 ].
	opackage clearPackage.
	self assert: opackage counter equals: 0.
	self assert: opackage packagePrice equals: 20.
	self assert: opackage packageTax equals: 0.
	self assert: package counter equals: 1.
	self assert: package packagePrice equals: 20.
	self assert: package packageTax equals: 10.

]
