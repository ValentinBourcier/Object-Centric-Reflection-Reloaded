Class {
	#name : #ROCGenericMopTest,
	#superclass : #TestCase,
	#instVars : [
		'package'
	],
	#category : #'Reflectivity-Object-Centric-Tests-tests'
}

{ #category : #initialization }
ROCGenericMopTest >> setUp [

	super setUp.
	package := ROCPackage new.
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

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testAnyAssignmentAfterCounter [

	package afterAnyAssignmentDo: [ package counter: package counter + 1 ].
	package calculatePackageTax.
	self assert: package counter equals: 2
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testAnyAssignmentBeforeCounter [

	package beforeAnyAssignmentDo: [ 
		package counter: package counter + 1 ].
	package calculatePackageTax.
	self assert: package counter equals: 2
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testAnyAssignmentInsteadCounter [

	package insteadAnyAssignmentDo: [ 
		package counter: package counter + 1 ].
	package calculatePackageTax.
	self assert: package counter equals: 2 
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testAnyMessageSendAfterCounter [

	package afterAnyMessageSendDo: [ 
		package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 2
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testAnyMessageSendBeforeCounter [

	package beforeAnyMessageSendDo: [ 
		package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 2
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testAnyMessageSendInsteadCounter [

	package insteadAnyMessageSendDo: [ 
		package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 2
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testInsideMessageSendBeforeCounter [

	package
		beforeMessageSendTo: #m1
		do: [ package counter: package counter + 1 ].
	package m2.
	self assert: package counter equals: 3
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testInsideMessageSendBeforeCounterSelfMessage [

	package
		beforeMessageSendTo: #m1
		do: [ package counter: package counter + 1 ].
	package m1.
	self assert: package counter equals: 0
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testMessageSendAfterFirstInstruction [

	package
		afterMessageSendTo: #setPackagePrice:andTax:
		do: [ package counter: package counter + 1 ].
	
	package setPackagePrice: 5 andTax: 7.
	self assert: package counter equals: 0.
	self assert: package packagePrice equals: 5.
	self assert: package packageTax equals: 7.
]

{ #category : #'tests - mop architecture' }
ROCGenericMopTest >> testMopCreation [

	| object mop |
	object := Object new.
	mop := object mop.
	self assert: mop object identicalTo: object 
]

{ #category : #'tests - mop architecture' }
ROCGenericMopTest >> testMopInstrumentation [

	| object mop |
	object := Object new.
	mop := object mop.

	mop proxifyObject.

	self assert: mop metaObject notNil
]

{ #category : #'tests - mop architecture' }
ROCGenericMopTest >> testMopRegistryAccess [

	| object mop |
	object := Object new.
	mop := ROCGenericMOP mopAt: object.

	self assert: mop identicalTo: (ROCGenericMOP mopRegistry at: object).
self assert: mop identicalTo: object mop.	
]

{ #category : #'tests - mop architecture' }
ROCGenericMopTest >> testMopWeakRegistry [

	| object mop |
	object := Object new.
	mop := ROCGenericMOP mopAt: object.

	self assert: mop identicalTo: (ROCGenericMOP mopRegistry at: object).

	object := nil.

	self
		should: [ ROCGenericMOP mopRegistry at: object ]
		raise: KeyNotFound
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testSpecificAssignmentAfterCounter [

	package
		afterAssignmentTo: #packagePrice
		do: [ package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 1.
	self assert: package packagePrice equals: 0.
	self assert: package packageTax equals: 0
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testSpecificAssignmentBeforeCounter [

	package
		beforeAssignmentTo: #packagePrice
		do: [ package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 1
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testSpecificAssignmentInsteadCounter [

	package
		insteadAssignmentTo: #packagePrice
		do: [ package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 1
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testSpecificMessageSendAfterCounter [

	package afterMessageSendTo:  #clearTaxes do:  [ 
		package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 1
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testSpecificMessageSendBeforeCounter [

	package beforeMessageSendTo:  #clearTaxes do:  [ 
		package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 1
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testSpecificMessageSendInsteadCounter [

	package insteadMessageSendTo: #clearTaxes do:  [ 
		package counter: package counter + 1 ].
	package clearPackage.
	self assert: package counter equals: 1
]

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testTwoObjectsMessageSendAfterChangingValueEachOther [

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
	opackage enableMOP.
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

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testTwoObjectsMessageSendBeforeChangingValueEachOther [

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
	opackage enableMOP.
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

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testTwoObjectsMessageSendInstead [

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
	opackage enableMOP.
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

{ #category : #'tests - reflective api' }
ROCGenericMopTest >> testTwoObjectsMessageSendInsteadChangingValueEachOther [

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
	opackage enableMOP.
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
