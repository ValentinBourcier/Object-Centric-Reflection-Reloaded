Class {
	#name : #RFProxyInstrumenterTest,
	#superclass : #TestCase,
	#instVars : [
		'instrumenter',
		'testObject'
	],
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFProxyInstrumenterTest >> setUp [
	super setUp.
	instrumenter := RFProxyInstrumenter for: self.
	testObject := Object new
]

{ #category : #tests }
RFProxyInstrumenterTest >> testBeForObject [
	
	instrumenter beForObject: testObject.
	self assert: instrumenter instrumentedObject identicalTo: testObject.
	self assert: instrumenter instrumentedClass identicalTo: testObject class.
	self assert: instrumenter instrumentedClass isAnonymous.
	self assert: instrumenter instrumentedClass superclass identicalTo: Object
]

{ #category : #'tests - method flattening' }
RFProxyInstrumenterTest >> testBuildSuperSendsChainFromSourceMethodToHighestMethodInClassHierarchy [

	|sourceMethod targetMethod chain lastFoundMethod|
	sourceMethod := Bub >> #mWithSuper.
	targetMethod := Bob >> #mWithSuper.
	chain := OrderedCollection new.
	
	lastFoundMethod := instrumenter buildSuperSendsChainFrom: sourceMethod upTo: nil in: chain.	
	
	self assert: chain size equals: 2.
	self assert: chain first identicalTo: sourceMethod.
	self assert: chain last identicalTo: (Bib >> #mWithSuper).
	self assert: lastFoundMethod identicalTo: targetMethod

	
]

{ #category : #'tests - method flattening' }
RFProxyInstrumenterTest >> testBuildSuperSendsChainFromSourceMethodToTargetMethod [

	|sourceMethod targetMethod chain lastFoundMethod|
	sourceMethod := Bub >> #mWithSuper.
	targetMethod := Bib >> #mWithSuper.
	chain := OrderedCollection new.
	
	lastFoundMethod := instrumenter buildSuperSendsChainFrom: sourceMethod upTo: targetMethod in: chain.	
	
	self assert: chain size equals: 1.
	self assert: chain first identicalTo: sourceMethod.
	self assert: lastFoundMethod identicalTo: targetMethod

	
]

{ #category : #'tests - method flattening' }
RFProxyInstrumenterTest >> testBuildSuperSendsChainFromSourceMethodToTargetMethodFailure [

	|sourceMethod targetMethod chain lastFoundMethod|
	sourceMethod := Bub >> #superUpToMiddleHierarchy.
	targetMethod := Bob >> #superUpToMiddleHierarchy.
	chain := OrderedCollection new.
	
	lastFoundMethod := instrumenter buildSuperSendsChainFrom: sourceMethod upTo: targetMethod in: chain.	
	self deny: lastFoundMethod identicalTo: targetMethod
	

]

{ #category : #'tests - method flattening' }
RFProxyInstrumenterTest >> testFindEmptySuperSendsChainFor [

	|method chain|	
	
	"Case 1: the method is not reachable from Bib instances"
	instrumenter beForObject: Bib new.
	method := Bub >> #mWithSuper.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assertEmpty: chain.
	
	"Case 2: the method is not reachable from Bub instances"
	instrumenter beForObject: Bub new.
	method := Bib >> #redefineNoSuper.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assertEmpty: chain
]

{ #category : #'tests - method flattening' }
RFProxyInstrumenterTest >> testFindSuperSendsChainFor [

	|method chain|	
	
	instrumenter beForObject: Bub new.
	
	"Case 1: the method is reachable from Bub instances but has no super calls"
	method := Bib >> #superUpToMiddleHierarchy.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assert: chain size equals: 2.
	self assert: chain first identicalTo: (Bub >> #superUpToMiddleHierarchy).
	self assert: chain last identicalTo: (Bib >> #superUpToMiddleHierarchy).
	
	"Case 2: the method is reachable from Bub instances and calls super up to Object"
	method := Bib >> #mWithSuper.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assert: chain size equals: 3.
	self assert: chain first identicalTo: (Bub >> #mWithSuper).
	self assert: chain second identicalTo: (Bib >> #mWithSuper).
	self assert: chain last identicalTo: (Bob >> #mWithSuper).
	
	"Case 2 variant"
	method := Bub >> #mWithSuper.
	chain := instrumenter findSuperSendsChainFor: method.	
	self assert: chain size equals: 3.
	self assert: chain first identicalTo: (Bub >> #mWithSuper).
	self assert: chain second identicalTo: (Bib >> #mWithSuper).
	self assert: chain last identicalTo: (Bob >> #mWithSuper).
]

{ #category : #tests }
RFProxyInstrumenterTest >> testInstantiation [

	self assert: instrumenter metaObject identicalTo: self
]

{ #category : #tests }
RFProxyInstrumenterTest >> testInstrumentedClass [

	instrumenter beForObject: testObject.
	self
		assert: instrumenter instrumentedClass
		identicalTo: testObject class
]

{ #category : #tests }
RFProxyInstrumenterTest >> testInstrumentedMessages [
	|im|
	im := instrumenter instrumentedMessages .
	self assert: im size equals: 1.
	self assert: (im includes: #class).
]

{ #category : #'tests - method flattening' }
RFProxyInstrumenterTest >> testIsMethodReachableInHierarchy [
	
	|method|
	instrumenter beForObject: Bib new.
	self assert: (instrumenter isClassReachableInHierarchy: Bib).
	
	method := Bub >> #mWithSuper.	
	self deny: (instrumenter isClassReachableInHierarchy: method methodClass).
	
	method := Bob >> #mWithSuper.
	self assert: (instrumenter isClassReachableInHierarchy: method methodClass).
	

	
]

{ #category : #tests }
RFProxyInstrumenterTest >> testNewLinkForSelector [
	|link interceptor|
	
	link := instrumenter newLinkForSelector: #selector.	
	self assert: link control equals: #instead.
	self assert: link selector equals: #execute.
	self assertEmpty: link arguments.
	self assert: link optionCompileOnLinkInstallation.
	
	interceptor := link metaObject.	
	self assert: interceptor selector identicalTo: #selector.
	self assert: interceptor metaObject equals: instrumenter metaObject.

	
	link := instrumenter newLinkForSelector: #selector:.	
	self assert: link control equals: #instead.
	self assert: link selector equals: #executeWithArgs:.
	self assert: link arguments equals: #(arguments).
	self assert: link optionCompileOnLinkInstallation.
	
	interceptor := link metaObject.	
	self assert: interceptor selector identicalTo: #selector:.
	self assert: interceptor metaObject equals: instrumenter metaObject

	
]

{ #category : #tests }
RFProxyInstrumenterTest >> testOriginalClass [

	instrumenter beForObject: testObject.
	self assert: instrumenter originalClass identicalTo: Object
]
